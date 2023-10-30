{
  nixpkgs.overlays = [
    (final: prev: {
      alejandra = prev.alejandra.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [ ../patches/alejandra-remove-ads.patch ];
      });
    })
  ];
}
