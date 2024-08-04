final: prev: {
  ironbar = prev.ironbar.overrideAttrs (oldAttrs: rec {
    version = "0.15.1-unstable-2024-08-04";

    src = prev.fetchFromGitHub {
      owner = "JakeStanger";
      repo = "ironbar";
      rev = "92c690dcd14c21272f89bfde292546a2ee828e23";
      hash = "sha256-YFarQSZEIFpA1/9eRK4tm88mZYvWGIaAgCEAjazBO38=";
    };

    patches = (oldAttrs.patches or [ ]) ++ [ ../assets/ironbar-fix-tray-crash.patch ];

    cargoDeps = oldAttrs.cargoDeps.overrideAttrs (
      prev.lib.const {
        name = "${oldAttrs.pname}-${version}-vendor.tar.gz";
        inherit src;
        outputHash = "sha256-wvjxKn2xS3qDJb7xVkLObr+Pz1djx+KHNSI66aonzpI=";
      }
    );
  });
}
