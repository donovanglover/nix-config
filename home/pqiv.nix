{
  programs.pqiv = {
    enable = true;

    settings = {
      options = {
        lazy-load = 1;
        hide-info-box = 1;
        scale-mode-screen-fraction = 1;
        max-depth = 0;
        background-pattern = "black";
        disable-backends = "archive,archive_cbx,libav,poppler,spectre";
        thumbnail-size = "256x256";
        command-1 = "thunar";
      };
    };
  };
}
