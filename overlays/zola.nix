final: prev: {
  zola = prev.zola.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [ ../patches/zola-serve-fix.patch ];
  });
}
