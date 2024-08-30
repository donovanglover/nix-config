{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ublock-origin";
  version = "1.59.0";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4328681/ublock_origin-${finalAttrs.version}.xpi";
    hash = "sha256-HbnGdqB9FB+NNtu8JPnj1kpswjQNv8bISLxDlfls+xQ=";
  };

  buildCommand = ''
    install -Dm644 "$src" "$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/uBlock0@raymondhill.net.xpi"
  '';

  meta = {
    homepage = "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/";
    description = "Efficient wide-spectrum content blocker";
    license = lib.licenses.gpl3Plus;
    platforms = lib.platforms.all;
  };
})
