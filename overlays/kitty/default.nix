{
  nixpkgs.overlays = [
    (final: prev: {
      kitty = prev.kitty.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [ ./fix-duplicate-lines.patch ];
      });
    })
  ];
}
