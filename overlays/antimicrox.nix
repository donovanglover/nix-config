final: prev: {
  antimicrox = prev.antimicrox.overrideAttrs (oldAttrs: {
    patches = (oldAttrs.patches or [ ]) ++ [
      ../assets/antimicrox-x11-niri-fix.patch
    ];
  });
}
