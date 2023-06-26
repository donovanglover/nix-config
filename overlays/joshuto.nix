{ lib, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      joshuto = prev.joshuto.overrideAttrs (oldAttrs: rec {
        version = "1d7f9067189fbf730605f373d591654651e01689";

        src = final.fetchFromGitHub {
          owner = "kamiyaa";
          repo = "joshuto";
          rev = version;
          sha256 = "sha256-QwFHZaMIlNhvAtQ3n/Ybav/t18FO5rUncZfJgnhkOsc=";
        };

        cargoDeps = oldAttrs.cargoDeps.overrideAttrs (lib.const {
          name = "joshuto.tar.gz";
          inherit src;
          outputHash = "sha256-Wb1yE/UKdp7yvmALVR3q6QM2v1I9nuEWIgEMggkGkTM=";
        });
      });
    })
  ];
}
