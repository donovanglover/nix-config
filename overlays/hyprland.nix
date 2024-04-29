final: prev: {
  hyprland = prev.hyprland.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [ ../patches/hyprland-fix-fcitx-window-focus.patch ];
  });
}
