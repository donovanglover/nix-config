final: prev: {
  rofi-wayland-unwrapped = prev.rofi-wayland-unwrapped.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [ ../assets/rofi-wayland-fix-touchpad-scrolling.patch ];
  });
}
