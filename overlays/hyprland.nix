final: prev: {
  hyprland = prev.hyprland.overrideAttrs (oldAttrs: rec {
    version = "0.39.1";

    src = prev.fetchFromGitHub {
      owner = "hyprwm";
      repo = "hyprland";
      rev = "v${version}";
      hash = "sha256-Urb/njWiHYUudXpmK8EKl9Z58esTIG0PxXw5LuM2r5g=";
    };
  });
}
