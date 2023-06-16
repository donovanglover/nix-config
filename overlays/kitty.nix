{
  nixpkgs.overlays = [
    (final: prev: {
      kitty = prev.kitty.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ ../patches/kitty-fix-duplicate-lines.patch ];
      });
    })
  ];
}
