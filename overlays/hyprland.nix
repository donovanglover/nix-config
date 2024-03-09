{
  nixpkgs.overlays = [
    (final: prev: {
      hyprland = prev.hyprland.overrideAttrs (oldAttrs: {
        version = "0.36.0-unstable-2024-03-08";

        src = prev.fetchFromGitHub {
          owner = "hyprwm";
          repo = "hyprland";
          rev = "024d4ddc74c9bd7945c4075c972575f20bc5b9bd";
          hash = "sha256-0nQNygrQ9fbbieo6o8eGmadQ19U372OTOu1WUcmZbIs=";
        };
      });
    })
  ];
}
