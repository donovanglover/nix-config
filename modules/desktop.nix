{ config, lib, nixpkgs, home-manager, hyprland, ... }: {
  imports = [ home-manager.nixosModule ];
  home-manager.users.user = { pkgs, ... }: {
    home.file.".icons/default/index.theme".text = ''
      [icon theme]
      Inherits=phinger-cursors
    '';
    xresources.properties = {
      "Xft.hinting" = true;
      "Xft.antialias" = true;
      "Xft.autohint" = false;
      "Xft.lcdfilter" = "lcddefault";
      "Xft.hintstyle" = "hintfull";
      "Xft.rgba" = "rgb";
    };
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
        window_padding_width = 10;
        tab_bar_margin_width = 10;
      };
    };
    xdg.configFile."kitty/diff.conf".text = ''
      map d scroll_to next-page
      map u scroll_to prev-page
      map g scroll_to start
      map G scroll_to end
    '';
    programs.swaylock = {
      package = pkgs."swaylock-effects";
      settings = {
        show-keyboard-layout = true;
        daemonize = true;
        font = "Noto Sans CJK JP";
        effect-blur = "5x2";
        clock = true;
        indicator = true;
        font-size = 25;
        indicator-radius = 85;
        indicator-thickness = 16;
        screenshots = true;
        fade-in = 1;
      };
    };
    programs.waybar = {
      enable = true;
      package = hyprland.packages."x86_64-linux".waybar-hyprland;
      settings = {
        mainBar = {
          layer = "bottom";
          position = "top";
          height = 30;
          modules-left = [ "wlr/taskbar" "tray" ];
          modules-center = [ "hyprland/window" ];
          modules-right = [ "battery" "backlight" "wireplumber" "clock" ];
        };
      };
    };
    programs.zathura = {
      enable = true;
      options = {
        guioptions = "v";
        adjust-open = "width";
        statusbar-basename = true;
        render-loading = false;
        scroll-step = 120;
      };
    };
  };
}
