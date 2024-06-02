{
  programs.yazi = {
    enable = true;

    settings = {
      manager = {
        ratio = [ 1 2 4 ];
        sort_dir_first = true;
        linemode = "mtime";
      };

      preview = {
        tab_size = 4;
        image_filter = "lanczos3";
        max_width = 1920;
        max_height = 1080;
        image_quality = 90;
      };
    };

    keymap = {
      manager.prepend_keymap = [
        {
          run = "remove --force";
          on = [ "d" ];
        }
      ];
    };
  };
}
