{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage {
  pname = "new-tab-identity";
  version = "0-unstable-2024-08-19";

  src = fetchFromGitHub {
    owner = "donovanglover";
    repo = "new-tab-identity";
    rev = "bf61dbda21d37b063062039ca246611ee83299ff";
    hash = "sha256-/1id7MHWxkPpuiSWqLYGYQBk5kNxBOUbkexkvTZDkfw=";
  };

  npmDepsHash = "sha256-M0WPgg91FupGz4383gHf13kSsmAkjygmKZ5IxsM3VE0=";

  installPhase = ''
    runHook preInstall

    install -Dm644 dist/new_tab_identity-1.0.zip "$out/share/mozilla/extensions/{ec8030f7-c20a-464f-9b0e-13a3a9e97384}/some-name@example.org.xpi"

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/donovanglover/new-tab-identity";
    description = "Browse the web from multiple VPN locations simultaneously";
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
}
