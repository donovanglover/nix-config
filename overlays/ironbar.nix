final: prev: {
  ironbar = prev.ironbar.overrideAttrs (oldAttrs: rec {
    version = "0.15.1-unstable-2024-06-03";

    src = prev.fetchFromGitHub {
      owner = "JakeStanger";
      repo = "ironbar";
      rev = "a93108b7e70694583897b755aacf73bd2d728656";
      hash = "sha256-VbNZkG8KR2iFG+93f+t5+OQIaS5k81WyhYL0z7bdOfY=";
    };

    cargoDeps = oldAttrs.cargoDeps.overrideAttrs (prev.lib.const {
      name = "${oldAttrs.pname}-${version}-vendor.tar.gz";
      inherit src;
      outputHash = "sha256-J7T00RV7mFCX0/e7n14LspoatPmlbNcB4u5UWWe8gSg=";
    });
  });
}
