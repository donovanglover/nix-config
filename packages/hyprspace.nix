{ lib
, stdenv
, fetchFromGitHub
, fetchpatch
, hyprland
, pkg-config
}:

stdenv.mkDerivation {
  pname = "hyprspace";
  version = "0-unstable-2024-06-17";

  src = fetchFromGitHub {
    owner = "KZDKM";
    repo = "hyprspace";
    rev = "2f3edb68f47a8f5d99d10b322e9a85a285f53cc7";
    hash = "sha256-iyj4D6c77uROAH9QdZjPd9SKnS/DuACMESqaEKnBgI8=";
  };

  # Fix build on Hyprland v0.41.2
  patches = fetchpatch {
    url = "https://github.com/KZDKM/Hyprspace/commit/edad6cf735097b7cb4406d3fc8daddd09dfa458a.patch";
    hash = "sha256-EVabjPymGAMPtC3Uf6lMJOInvccJhu4t09NXhXhq4RY=";
  };

  nativeBuildInputs = [
    pkg-config
    hyprland
  ];

  buildInputs = [ hyprland ] ++ hyprland.buildInputs;

  dontUseCmakeConfigure = true;

  installPhase = ''
    runHook preInstall

    mkdir -p $out/lib
    mv Hyprspace.so $out/lib/libhyprspace.so

    runHook postInstall
  '';

  meta = {
    homepage = "https://github.com/KZDKM/Hyprspace";
    description = "Workspace overview plugin for Hyprland";
    license = lib.licenses.gpl2Only;
    platforms = lib.platforms.linux;
    maintainers = with lib.maintainers; [ donovanglover ];
  };
}
