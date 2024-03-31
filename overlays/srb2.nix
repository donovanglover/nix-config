(final: prev: {
  srb2 = prev.srb2.overrideAttrs (oldAttrs: {
    desktopItems = [
      (prev.makeDesktopItem rec {
        name = "Sonic Robo Blast 2";
        exec = oldAttrs.pname;
        icon = oldAttrs.pname;
        comment = oldAttrs.meta.description;
        desktopName = name;
        genericName = name;
        startupWMClass = ".srb2-wrapped";
        categories = [ "Game" ];
      })
    ];
  });
})
