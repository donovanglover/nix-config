{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "showdex";
  version = "1.2.4";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4329311/showdex-${finalAttrs.version}.xpi";
    hash = "sha256-V2TbyhrB1mrkF7PdJrPdvN+umJXbEcbSKA2jfVPFvV8=";
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
