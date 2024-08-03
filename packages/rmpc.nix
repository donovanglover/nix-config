{
  lib,
  rustPlatform,
  fetchFromGitHub,
  pkg-config,
  cmake,
}:

rustPlatform.buildRustPackage {
  pname = "rmpc";
  version = "0.2.1-unstable-2024-07-27";

  src = fetchFromGitHub {
    owner = "mierak";
    repo = "rmpc";
    rev = "f12be6f606f5319523f41576e7c463b6008b9069";
    hash = "sha256-mKTl2sZdrkecd9fMBllHC0YiVHK8rUdoRmN2YF4T9O0=";
  };

  cargoHash = "sha256-/00WGuuxtwtpNuEEeapJhVedbg3RMUtTEQbYYu518po=";

  cargoPatches = [ ../assets/rmpc-support-older-rustc.patch ];

  nativeBuildInputs = [
    pkg-config
    cmake
  ];

  meta = {
    description = "Configurable, terminal-based media player client with album art support via kitty image protocol";
    homepage = "https://github.com/mierak/rmpc";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ donovanglover ];
    mainProgram = "rmpc";
  };
}
