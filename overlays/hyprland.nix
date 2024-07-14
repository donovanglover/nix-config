final: prev: {
  hyprland = prev.hyprland.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      ../assets/hyprland-fix-keyboard-focus.patch
    ];
  });
}
