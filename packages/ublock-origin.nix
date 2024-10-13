{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "ublock-origin";
  version = "1.60.0";

  src = fetchurl {
    url = "https://github.com/gorhill/uBlock/releases/download/${finalAttrs.version}/uBlock0_${finalAttrs.version}.firefox.signed.xpi";
    hash = "sha256-4s2psqGwp/bl7w2p+H8o31L4VgWHui5RowAxIc+4FgA=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 "$src" "$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/uBlock0@raymondhill.net.xpi"

    runHook postInstall
  '';

  meta = {
    homepage = "https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/";
    description = "Efficient wide-spectrum content blocker";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
})
