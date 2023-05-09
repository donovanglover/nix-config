{ config, lib, nixpkgs, home-manager, ... }: {
  imports = [ home-manager.nixosModule ];
  home-manager.users.user = { pkgs, ... }: {
    programs.kitty = {
      enable = true;
      font = {
        package = pkgs."maple-mono-NF";
        name = "MapleMono-NF";
      };
      settings = {
        enable_audio_bell = false;
        allow_remote_control = true;
        dynamic_background_opacity = true;
        background_opacity = "0.9";
        close_on_child_death = true;
      };
    };
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
    programs.alacritty = {
      enable = true;
      settings = {
        window.opacity = 0.9;
        window.padding.x = 10;
        window.padding.y = 10;
        window.decorations = "none";
        window.startup_mode = "Maximized";
        window.decorations_theme_variant = "Dark";
        font.normal.family = "MapleMono-NF";
        font.size = 11;
        draw_bold_text_with_bright_colors = true;
        selection.save_to_clipboard = true;
        cursor.style.shape = "Beam";
        cursor.style.blinking = "Always";
        mouse.hide_when_typing = true;
      };
    };
  };
}
