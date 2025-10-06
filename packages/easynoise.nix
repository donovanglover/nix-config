{
  lib,
  stdenvNoCC,
  fetchFromGitHub,
  makeWrapper,
  mpv,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "easynoise";
  version = "0.10";

  src = fetchFromGitHub {
    owner = "cliambrown";
    repo = "EasyNoise";
    rev = "v${finalAttrs.version}";
    hash = "sha256-ZzpfmJxRMJNTtifYLCk2w5iBvP1qA56s7Rz3PMhuxqM=";
  };

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dm644 app/src/main/res/raw/*.wav -t $out/share/easynoise

    echo "mpv --volume=20 --loop-file $out/share/easynoise/fuzz.wav" > easynoise

    install -Dm755 easynoise -t $out/bin

    runHook postInstall
  '';

  postInstall = ''
    wrapProgram $out/bin/easynoise \
      --prefix PATH ":" "${
        lib.makeBinPath [
          mpv
        ]
      }"
  '';

  meta = {
    description = "Simple app to play white noise";
    homepage = "https://github.com/cliambrown/EasyNoise";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
    mainProgram = "easynoise";
  };
})
