{
  lib,
  stdenv,
  fetchFromGitHub,
  pkg-config,
  gtk3,
  gtk-layer-shell,
  glib,
  wrapGAppsHook3,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "desktop-icons";
  version = "0-unstable-2024-02-25";

  src = fetchFromGitHub {
    owner = "Geronymos";
    repo = "desktop-icons";
    rev = "5a1f4e12fcf405df7daf0986eb580efaad37c3c2";
    hash = "sha256-Hp+eMai0KhFsD8rgs5TaEVSNviF9MhyNfKttzekAgQg=";
  };

  nativeBuildInputs = [
    pkg-config
    wrapGAppsHook3
  ];

  buildInputs = [
    gtk3
    gtk-layer-shell
  ];

  env.NIX_CFLAGS_COMPILE = "-I${glib.dev}/include/gio-unix-2.0";

  installPhase = ''
    runHook preInstall

    install -Dm755 dicons $out/bin/dicons

    runHook postInstall
  '';

  meta = {
    description = "Show files from a directory on the desktop for wlroots based compositors";
    homepage = "https://github.com/Geronymos/desktop-icons";
    license = lib.licenses.gpl3Only;
    maintainers = with lib.maintainers; [ donovanglover ];
    mainProgram = "dicons";
    platforms = lib.platforms.all;
  };
})
