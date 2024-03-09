{
  nixpkgs.overlays = [
    (final: prev: {
      hyprlang = prev.hyprlang.overrideAttrs (oldAttrs: rec {
        version = "0.5.0";

        src = prev.fetchFromGitHub {
          owner = "hyprwm";
          repo = "hyprlang";
          rev = "v${version}";
          hash = "sha256-bR4o3mynoTa1Wi4ZTjbnsZ6iqVcPGriXp56bZh5UFTk=";
        };
      });
    })
  ];
}
