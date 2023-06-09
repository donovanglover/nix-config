{pkgs, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      rofi-unwrapped = prev.rofi-unwrapped.overrideAttrs (oldAttrs: rec {
        version = "d06095b5ed40e5d28236b7b7b575ca867696d847";

        src = final.fetchFromGitHub {
          owner = "lbonn";
          repo = "rofi";
          rev = version;
          fetchSubmodules = true;
          sha256 = "sha256-8IfHpaVFGeWqyw+tLjNtg+aWwAHhSA5PuXJYjpoht2E=";
        };

        nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [pkgs.wayland-scanner];
        buildInputs = oldAttrs.buildInputs ++ [pkgs.wayland pkgs.wayland-protocols];
      });
    })
  ];
}
