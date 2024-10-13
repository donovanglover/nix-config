{
  lib,
  stdenvNoCC,
  fetchurl,
  gitUpdater,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "yomitan";
  version = "24.10.7.0";

  src = fetchurl {
    url = "https://github.com/yomidevs/yomitan/releases/download/${finalAttrs.version}/yomitan-firefox.zip";
    hash = "sha256-d2PmqLm3uYVc2S5hUFe9zOnbih7N7f2mQKc5O8qqPs8=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 "$src" "$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/{6b733b82-9261-47ee-a595-2dda294a4d08}.xpi"

    runHook postInstall
  '';

  passthru.updateScript = gitUpdater {
    url = "https://github.com/yomidevs/yomitan";
  };

  meta = {
    homepage = "https://addons.mozilla.org/en-US/firefox/addon/yomitan/";
    description = "Japanese dictionary with Anki integration";
    license = lib.licenses.gpl3Plus;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
})
