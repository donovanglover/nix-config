{
  lib,
  stdenv,
  hyprland,
  fetchFromGitHub,
}:

stdenv.mkDerivation {
  pname = "hycov";
  version = "0.1";

  src = fetchFromGitHub {
    owner = "Ayuei";
    repo = "hycov";
    rev = "db6ea8a24f0a58fa69f86db49d7c853754b1b8e1";
    hash = "sha256-fSujEAViKqQusHyYe7Qg8QnLlyUNOf0/Jk1P70BmiyE=";
  };

  inherit (hyprland) nativeBuildInputs;

  buildInputs = [ hyprland ] ++ hyprland.buildInputs;

  meta = with lib; {
    homepage = "https://github.com/Ayuei/hycov";
    description = "Clients overview for hyprland plugin";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
