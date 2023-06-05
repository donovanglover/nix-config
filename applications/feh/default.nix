{
  home-manager.sharedModules = [{
    programs.feh = {
      enable = true;

      keybindings = {
        next_img = [ "k" "Right" ];
        prev_img = [ "j" "Left" ];
        quit = "q";
        toggle_fullscreen = "f";

        zoom_in = "h";
        zoom_out = "l";

        toggle_filenames = "d";
        toggle_fixed_geometry = "g";
        toggle_pause = "h";
        toggle_pointer = "a";
        size_to_image = "w";
        jump_random = "z";
        jump_first = "J";
        jump_last = "K";
        jump_fwd = "H";
        jump_back = "L";
        scroll_left = "b";
        scroll_right = "n";
        scroll_up = [ "u" "Up" ];
        scroll_down = [ "d" "Down" ];
        zoom_default = "o";
        zoom_fill = "p";
        toggle_auto_zoom = "m";

        toggle_actions = null;
        toggle_aliasing = null;
        toggle_caption = null;
        toggle_exif = null;
        save_filelist = null;
        toggle_info = null;
        toggle_keep_vp = null;
        toggle_menu = null;
        reload_image = null;
        save_image = null;
        prev_dir = null;
        next_dir = null;
        orient_3 = null;
        orient_1 = null;
        flip = null;
        mirror = null;
        action_0 = null;
        action_1 = null;
        action_2 = null;
        action_3 = null;
        action_4 = null;
        action_5 = null;
        action_6 = null;
        action_7 = null;
        action_8 = null;
        action_9 = null;
        close = null;
        reload_plus = null;
        reload_minus = null;
        remove = null;
        delete = null;
        scroll_left_page = null;
        scroll_right_page = null;
        scroll_up_page = null;
        scroll_down_page = null;
        render = null;
        zoom_fit = null;
        menu_close = null;
        menu_up = null;
        menu_down = null;
        menu_parent = null;
        menu_child = null;
        menu_select = null;
      };
    };
  }];
}
