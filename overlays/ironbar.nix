final: prev: {
  ironbar = prev.ironbar.overrideAttrs (oldAttrs: rec {
    version = "0.15.1-unstable-2024-07-13";

    src = prev.fetchFromGitHub {
      owner = "JakeStanger";
      repo = "ironbar";
      rev = "58190ab079d00dd53babb72346f1da6e1cc9ac72";
      hash = "sha256-Se+Pg81W8R+SFGFlhF1dU+NnMWSdLo3nC9TdPHa2IL4=";
    };

    cargoDeps = oldAttrs.cargoDeps.overrideAttrs (
      prev.lib.const {
        name = "${oldAttrs.pname}-${version}-vendor.tar.gz";
        inherit src;
        outputHash = "sha256-VkSznG2REXNhUKEVWwqlfA7BF9zXC+fxTgNeRfYaHi4=";
      }
    );
  });
}
