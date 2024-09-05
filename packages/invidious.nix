{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "invidious";
  version = "2.0.0";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/3661232/invidious_site-${finalAttrs.version}.xpi";
    hash = "sha256-xSyVIz5uqdUoaW+IacG6+VpgBzPUBbpOoXx2x6OrPBQ=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 "$src" "$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/{0d069122-737b-44f3-8309-80020b0d0c70}.xpi"

    runHook postInstall
  '';

  meta = {
    homepage = "https://addons.mozilla.org/en-US/firefox/addon/invidious-site/";
    description = "Redirect YouTube links to Invidious";
    license = lib.licenses.mpl20;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
})
