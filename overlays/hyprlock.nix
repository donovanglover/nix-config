{
  nixpkgs.overlays = [
    (final: prev: {
      hyprlock = prev.hyprlock.overrideAttrs (oldAttrs: rec {
        version = "0.2.0";

        src = prev.fetchFromGitHub {
          owner = "hyprwm";
          repo = "hyprlock";
          rev = "v${version}";
          hash = "sha256-1p6Y/8+ETaz7GQ8wsXLUTrk2dD0YN9ySOfwjRp2TSG4=";
        };
      });
    })
  ];
}
