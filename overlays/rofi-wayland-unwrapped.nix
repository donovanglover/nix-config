final: prev: {
  rofi-wayland-unwrapped = prev.rofi-wayland-unwrapped.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      (prev.fetchpatch {
        url = "https://github.com/lbonn/rofi/commit/93ad86da10b1747f4e584bc6bfbfbc3eddb280a3.patch";
        hash = "sha256-COWlVTa/C8oySxLdNo8w3W5WiujGIr/cDfXQWRkI1yw=";
      })
    ];
  });
}
