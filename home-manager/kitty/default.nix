{
  home-manager.sharedModules = [{
    programs.kitty = {
      enable = true;
      settings = {
        enable_audio_bell = false;
        allow_remote_control = true;
        dynamic_background_opacity = true;
        background_opacity = "0.95";
        close_on_child_death = true;
        cursor_blink_interval = 0;
        wayland_titlebar_color = "background";
        listen_on = "unix:/tmp/kitty";
        open_url_with = "librewolf";
        window_padding_width = 5;
        tab_bar_margin_width = 5;
      };
    };
    xdg.configFile."kitty/diff.conf".text = ''
      map d scroll_to next-page
      map u scroll_to prev-page
      map g scroll_to start
      map G scroll_to end
    '';
  }];
}
