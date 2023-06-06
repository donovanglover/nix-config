{
  stdenv,
  lib,
  fetchFromGitHub,
  rofi-unwrapped,
  wayland-scanner,
  wayland-protocols,
  wayland,
}:
rofi-unwrapped.overrideAttrs (oldAttrs: rec {
  pname = "rofi-wayland-unwrapped";
  version = "git";

  src = fetchFromGitHub {
    owner = "lbonn";
    repo = "rofi";
    rev = "d06095b5ed40e5d28236b7b7b575ca867696d847";
    fetchSubmodules = true;
    sha256 = "sha256-8IfHpaVFGeWqyw+tLjNtg+aWwAHhSA5PuXJYjpoht2E=";
  };

  nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [wayland-scanner];
  buildInputs = oldAttrs.buildInputs ++ [wayland wayland-protocols];

  meta = with lib; {
    description = "Window switcher, run dialog and dmenu replacement for Wayland";
    homepage = "https://github.com/lbonn/rofi";
    license = licenses.mit;
    maintainers = with maintainers; [bew];
    platforms = with platforms; linux;
  };
})
