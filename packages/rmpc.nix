{ lib
, rustPlatform
, fetchFromGitHub
, pkg-config
, cmake
}:

rustPlatform.buildRustPackage rec {
  pname = "rmpc";
  version = "0.2.1";

  src = fetchFromGitHub {
    owner = "mierak";
    repo = "rmpc";
    rev = "v${version}";
    hash = "sha256-g+yzW0DfaBhJKTikYZ8eqe4pX8nJvbpJ1xaZ3W/O/bo=";
  };

  cargoHash = "sha256-wFrHgB4wYGeXvfdGf4SJAAL8fE6dAKDLL51Ohmn+1HQ=";

  cargoPatches = [
    ../assets/rmpc-support-older-rustc.patch
  ];

  buildType = "debug";

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
