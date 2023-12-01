{
  nixpkgs.overlays = [
    (final: prev: {
      ripgrep = prev.ripgrep.overrideAttrs (oldAttrs: rec {
        version = "14.0.3";

        src = prev.fetchFromGitHub {
          owner = "BurntSushi";
          repo = "ripgrep";
          rev = version;
          hash = "sha256-NBGbiy+1AUIBJFx6kcGPSKo08a+dkNo4rNH2I1pki4U=";
        };

        cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
          name = "ripgrep-vendor.tar.gz";
          inherit src;
          outputHash = "sha256-ptWXv4MKM3M4KcFqI0v9LScMBRHkwzvDOVbLxyJtHFU=";
        });
      });
    })
  ];
}
