final: prev: {
  wvkbd = prev.wvkbd.overrideAttrs (oldAttrs: {
    makeFlags = (oldAttrs.makeFlags or [ ]) ++ [
      "LAYOUT=deskintl"
    ];

    meta.mainProgram = "wvkbd-deskintl";
  });
}
