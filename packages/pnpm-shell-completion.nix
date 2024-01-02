{ rustPlatform
, fetchFromGitHub
, lib
, installShellFiles
}:

rustPlatform.buildRustPackage rec {
  pname = "pnpm-shell-completion";
  version = "0.5.2";

  src = fetchFromGitHub {
    owner = "g-plane";
    repo = "pnpm-shell-completion";
    rev = "v${version}";
    hash = "sha256-VCIT1HobLXWRe3yK2F3NPIuWkyCgckytLPi6yQEsSIE=";
  };

  cargoHash = "sha256-SzB5hwh7rIxKM3O9ffQzrzCwbwqPQ+QZP7Pb5PNVqmE=";

  nativeBuildInputs = [
    installShellFiles
  ];

  postInstall = /* bash */ ''
    installShellCompletion --cmd pnpm \
      --fish pnpm-shell-completion.fish \
      --zsh pnpm-shell-completion.plugin.zsh
  '';

  meta = with lib; {
    homepage = "https://github.com/g-plane/pnpm-shell-completion";
    description = "Complete your pnpm command fastly";
    license = licenses.mit;
    maintainers = with maintainers; [ donovanglover ];
    mainProgram = "pnpm-shell-completion";
  };
}
