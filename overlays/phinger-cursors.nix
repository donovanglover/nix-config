final: prev: {
  phinger-cursors = prev.phinger-cursors.overrideAttrs (oldAttrs: rec {
    version = "1.1";

    src = prev.fetchurl {
      url = "https://github.com/phisch/phinger-cursors/releases/download/v${version}/phinger-cursors-variants.tar.bz2";
      sha256 = "sha256-II+1x+rcjGRRVB8GYkVwkKVHNHcNaBKRb6C613901oc=";
    };
  });
}
