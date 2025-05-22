{
  lib,
  stdenvNoCC,
  writeTextFile,
  makeWrapper,
  fish,
  pipewire,
  ffmpeg,
  libnotify,
  wl-clipboard-rs,
  xclip,
}:

let
  record = writeTextFile {
    name = "record";
    text = # fish
      ''
        #!/usr/bin/env fish

        if pgrep pw-record
          pkill pw-record

          exit 0
        end

        notify-send \
          --hint "string:x-dunst-stack-tag:record" \
          "録音" \
          "中"

        set DIRECTORY "/tmp/"
        set FILENAME "録音_$(date --iso-8601)-$(uuidgen)"

        pw-record -P "{ stream.capture.sink=true }" "$DIRECTORY$FILENAME.flac"
        ffmpeg -i "$DIRECTORY$FILENAME.flac" -c:a libopus -b:a 128K "$DIRECTORY$FILENAME.opus"

        if test "$XDG_SESSION_TYPE" = "x11"
          echo "file://$DIRECTORY$FILENAME.opus" | xclip -selection clipboard
        else
          echo "file://$DIRECTORY$FILENAME.opus" | wl-copy -t text/uri-list
        end

        notify-send \
          --hint "string:x-dunst-stack-tag:record" \
          "録音" \
          "成功"
      '';
  };
in
stdenvNoCC.mkDerivation {
  pname = "record";
  version = "0.1.0";

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dm755 ${record} $out/bin/record

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram "$out/bin/record" \
      --prefix PATH ":" "${
        lib.makeBinPath [
          fish
          pipewire
          ffmpeg
          libnotify
          wl-clipboard-rs
          xclip
        ]
      }"
  '';

  meta = {
    homepage = "https://github.com/donovanglover/nix-config";
    description = "Script to record desktop audio and copy the result to the clipboard";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.linux;
    mainProgram = "record";
  };
}
