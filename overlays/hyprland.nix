{
  nixpkgs.overlays = [
    (final: prev: {
      hyprland = prev.hyprland.overrideAttrs (old: {
        patches = (old.patches or [ ]) ++ [
          ../patches/hyprland-window-sizes.patch
          ../patches/hyprland-slidefade-animation.patch
        ];
      });
    })
  ];
}

