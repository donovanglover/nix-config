{ lib
, rustPlatform
, fetchFromGitHub
}:

rustPlatform.buildRustPackage {
  pname = "mdopen";
  version = "unstable-2024-03-29";

  src = fetchFromGitHub {
    owner = "immanelg";
    repo = "mdopen";
    rev = "a545d7c5671914e87e08934950ee1982cd74a7a6";
    hash = "sha256-ztKkKOxFmfqg522u5RxXBl9YZyeykKRBxKIYE6ksLn0=";
  };

  cargoHash = "sha256-O9yw/qVUjszuD0DXxvH90tXVKKTdRXQFJhYXpZ+Gr8E=";

  meta = with lib; {
    description = "Preview Markdown Files";
    homepage = "https://github.com/immanelg/mdopen";
    license = licenses.bsd3;
    maintainers = with maintainers; [ donovanglover ];
    mainProgram = "mdopen";
  };
}
