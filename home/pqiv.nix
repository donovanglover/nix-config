{
  programs.pqiv = {
    enable = true;

    settings = {
      options = {
        lazy-load = true;
        hide-info-box = true;
        scale-mode-screen-fraction = true;
        background-pattern = "black";
        disable-backends = "archive,archive_cbx,libav,poppler,spectre";
        thumbnail-size = "256x256";
        command-1 = "thunar";
        command-2 = "trash put";
      };
    };

    extraConfig = ''
      [actions]
      set_cursor_auto_hide(1)
    '';
  };
}
