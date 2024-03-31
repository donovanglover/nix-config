(final: prev: {
  kitty = prev.kitty.overrideAttrs (oldAttrs: rec {
    version = "0.31.0";

    src = prev.fetchFromGitHub {
      owner = "kovidgoyal";
      repo = "kitty";
      rev = "refs/tags/v${version}";
      hash = "sha256-VWWuC4T0pyTgqPNm0gNL1j3FShU5b8S157C1dKLon1g=";
    };

    goModules = (prev.buildGoModule {
      pname = "kitty-go-modules";
      inherit src version;
      vendorHash = "sha256-OyZAWefSIiLQO0icxMIHWH3BKgNas8HIxLcse/qWKcU=";
    }).goModules;

    patches = (oldAttrs.patches or [ ]) ++ [
      ../patches/kitty-wlroots-copying-fix.patch
    ];
  });
})
