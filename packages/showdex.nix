{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "showdex";
  version = "1.2.5-b1923BC50731";

  src = fetchurl {
    url = "https://github.com/doshidak/showdex/releases/download/v${finalAttrs.version}/showdex-v${finalAttrs.version}.firefox.xpi";
    hash = "sha256-wn0pF8ar5Ldfc/kNMznzg9NAz+5ckZB7SCEUObj0BPw=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 "$src" "$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/showdex@tize.io.xpi"

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/doshidak/showdex";
    description = "Pokémon Showdown extension that harnesses the power of parabolic calculus to strategically extract your opponents' Elo";
    license = lib.licenses.agpl3Only;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
})
