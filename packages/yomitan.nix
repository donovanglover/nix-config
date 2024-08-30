{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "yomitan";
  version = "24.8.19.0";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4343062/yomitan-${finalAttrs.version}.xpi";
    hash = "sha256-Ki6AbZeaW28tAYZWTIOU2HLq/9zlGyrms3z3LANsc5U=";
  };

  buildCommand = ''
    install -Dm644 "$src" "$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/{6b733b82-9261-47ee-a595-2dda294a4d08}.xpi"
  '';

  meta = {
    homepage = "https://addons.mozilla.org/en-US/firefox/addon/yomitan/";
    description = "Japanese dictionary with Anki integration";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.all;
  };
})
