{ config, lib, nixpkgs, home-manager, hyprland, ... }: {
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
