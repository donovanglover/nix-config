{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "redlib";
  version = "3.2";

  src = fetchurl {
    url = "https://addons.mozilla.org/firefox/downloads/file/4330244/redlib-${finalAttrs.version}.xpi";
    hash = "sha256-j6A/CQ56hKOLgaDcmJBVE9lThn8js4xDkj88wqIzBE8=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall

    install -Dm644 "$src" "$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/{5003e502-f361-4bf6-b09e-41a844d36d33}.xpi"

    runHook postInstall
  '';

  meta = {
    homepage = "https://addons.mozilla.org/en-US/firefox/addon/redlib/";
    description = "Redirect to Redlib with Farside";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
})
