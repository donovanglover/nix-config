{
  lib,
  stdenvNoCC,
  writeTextFile,
  makeWrapper,
  fish,
  v4l-utils,
  ffmpeg,
}:

let
  pinephone-video = writeTextFile {
    name = "pinephone-video";
    text = # fish
      ''
        media-ctl -d1 --links '"gc2145 3-003c":0->1:0[0],"ov5640 3-004c":0->1:0[1]'
        media-ctl -d1 --set-v4l2 '"ov5640 3-004c":0[fmt:UYVY8_2X8/1280x720@1/30]'

        ffmpeg \
          -input_format yuv420p \
          -s 1280x720 \
          -f video4linux2 \
          -thread_queue_size 4096 \
          -i /dev/video1 \
          -f pulse \
          -thread_queue_size 256 \
          -i alsa_input.platform-sound.Voice_Call__DigitalMic__source \
          -c:a libopus \
          -c:v libx264 \
          -preset ultrafast \
          -qp 23 \
          "$(date '+%x（%a）%R').mp4"
      '';
  };
in
stdenvNoCC.mkDerivation {
  pname = "pinephone-scripts";
  version = "0.1.0";

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dm755 ${pinephone-video} $out/bin/pinephone-video

    runHook postInstall
  '';

  postInstall = ''
    for bin in $out/bin/*; do
      wrapProgram "$bin" \
        --prefix PATH ":" "${
          lib.makeBinPath [
            fish
            v4l-utils
            ffmpeg
          ]
        }"
    done
  '';

  meta = {
    homepage = "https://github.com/donovanglover/nix-config";
    description = "PinePhone-specific scripts like video recording";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.linux;
  };
}
