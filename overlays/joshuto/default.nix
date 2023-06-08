{lib, ...}: {
  nixpkgs.overlays = [
    (final: prev: {
      joshuto = prev.joshuto.overrideAttrs (oldAttrs: rec {
        version = "493af3185092036cbbae81ae620b101f66cf4e9a";
        src = final.fetchFromGitHub {
          owner = "kamiyaa";
          repo = "joshuto";
          rev = version;
          sha256 = "sha256-jLlDMV03eFWDB1D6pFEq2MFAfoVwFTy8ZpweS9syDB0=";
        };

        cargoDeps = oldAttrs.cargoDeps.overrideAttrs (lib.const {
          name = "joshuto.tar.gz";
          inherit src;
          outputHash = "sha256-cDy7sccuZj+RNjaDGjqczGl//zgmMAifjv/ZMEO/yyY=";
        });
      });
    })
  ];
}
