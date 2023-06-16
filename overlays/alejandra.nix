{
  nixpkgs.overlays = [
    (final: prev: {
      alejandra = prev.alejandra.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ ../patches/alejandra-remove-ads.patch ];
      });
    })
  ];
}
