{
  nixpkgs.overlays = [
    (final: prev: {
      eza = prev.eza.overrideAttrs (oldAttrs: rec {
        version = "0.14.2";

        src = prev.fetchFromGitHub {
          owner = "eza-community";
          repo = "eza";
          rev = "v${version}";
          hash = "sha256-eST70KMdGgbTo4FNL3K5YGn9lwIGroG4y4ExKDb30hU=";
        };

        cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
          name = "eza-vendor.tar.gz";
          inherit src;
          outputHash = "sha256-bF4Thh/KUOLQz4MmM0WqQmXXT8dsLjy9ngy1UN5ACk8=";
        });
      });
    })
  ];
}
