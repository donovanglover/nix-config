{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "joshuto";
  version = "493af3185092036cbbae81ae620b101f66cf4e9a";

  src = fetchFromGitHub {
    owner = "kamiyaa";
    repo = pname;
    rev = version;
    sha256 = "sha256-jLlDMV03eFWDB1D6pFEq2MFAfoVwFTy8ZpweS9syDB0=";
  };

  cargoSha256 = "sha256-dffKMgXhm4VpDSEzFW5d4oGCBKY/ppj1gx29Iw3Msc8=";

  meta = with lib; {
    description = "Ranger-like terminal file manager written in Rust";
    homepage = "https://github.com/kamiyaa/joshuto";
    license = licenses.lgpl3Only;
    maintainers = with maintainers; [figsoda totoroot];
  };
}
