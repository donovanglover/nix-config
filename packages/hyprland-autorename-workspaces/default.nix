{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:
rustPlatform.buildRustPackage rec {
  pname = "hyprland-autoname-workspaces";
  version = "1.0.0";

  src = fetchFromGitHub {
    owner = "hyprland-community";
    repo = pname;
    rev = version;
    sha256 = "sha256-+oJWPSN6VmUUpd5ZLrN5Sa9Yg6pqVlaQFSRnEkLpLt8=";
  };

  cargoSha256 = "sha256-wXQVcTQ6up34ZqJP5hDttFEqtz+hmyd1aWFnPlFvazA=";

  meta = with lib; {
    description = "Automatically rename the workspaces with icons of started applications";
    homepage = "https://github.com/hyprland-community/hyprland-autoname-workspaces";
    license = licenses.isc;
    maintainers = with maintainers; [donovanglover];
  };
}
