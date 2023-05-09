{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configuration.nix
        ./modules/editor.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          users.users.user = {
            isNormalUser = true;
            extraGroups = [ "wheel" "networkmanager" ];
          };
          home-manager.users.user = { pkgs, ... }: {
            home.username = "user";
            home.homeDirectory = "/home/user";
            home.packages = [ pkgs.httpie ];
            home.stateVersion = "22.11";
            programs.mpv.enable = true;
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
            programs.librewolf = {
              enable = true;
              settings = {
                "middlemouse.paste" = false;
                "browser.download.useDownloadDir" = true;
                "ui.use_activity_cursor" = true;
                "browser.tabs.insertAfterCurrent" = true;
              };
            };
            programs.gitui.enable = true;
            programs.git = { diff-so-fancy = { enable = true; }; };
            programs.lf = { enable = true; };
            programs.waybar = {
              enable = true;
              settings = {
                mainBar = {
                  layer = "bottom";
                  position = "top";
                  height = 30;
                  modules-left = [ "wlr/taskbar" "tray" ];
                  modules-center = [ "hyprland/window" ];
                  modules-right =
                    [ "battery" "backlight" "wireplumber" "clock" ];
                };
              };
            };
            services.udiskie.enable = true;
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
            editorconfig = {
              enable = true;
              settings = {
                "*" = {
                  charset = "utf-8";
                  end_of_line = "lf";
                  insert_final_newline = true;
                  indent_size = 2;
                  indent_style = "space";
                  trim_trailing_whitespace = true;
                };
                "*.md" = { indent_style = "tab"; };
                "Makefile" = {
                  indent_style = "tab";
                  indent_size = 4;
                };
                "*.html" = {
                  indent_style = "tab";
                  indent_size = 4;
                };
                "*.go" = {
                  indent_style = "tab";
                  indent_size = 4;
                };
              };
            };
          };
        }
      ];
    };
  };
}
