{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, hyprland, stylix, ... }@attrs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = attrs;
      modules = [
        ./configuration.nix
        ./modules/editor.nix
        ./modules/desktop.nix
        hyprland.nixosModules.default
        {
          programs.hyprland.enable = true;
        }
        stylix.nixosModules.stylix
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
            programs.mpv = {
              enable = true;
              config = {
                screenshot-format = "png";
                profile = "gpu-hq";
                scale = "ewa_lanczossharp";
                cscale = "ewa_lanczossharp";
                video-sync = "display-resample";
                interpolation = true;
                tscale = "oversample";
                sub-auto = "fuzzy";
                sub-font = "Noto Sans CJK JP Medium";
                sub-blur = 10;
                sub-file-paths = "subs:subtitles:字幕";
                fullscreen = "yes";
                title = "\${filename} - mpv";
                script-opts = "osc-title=\${filename},osc-boxalpha=150,osc-showfullscreen=no,osc-boxvideo=yes";
                osc = "no";
                osd-on-seek = "no";
                osd-bar = "no";
                osd-bar-w = 30;
                osd-bar-h = "0.2";
                osd-duration = 750;
                really-quiet = "yes";
              };
              scripts = [ pkgs.mpvScripts.thumbnail ];
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
            programs.git = { diff-so-fancy = { enable = true; }; };
            programs.lf = { enable = true; };
            services.udiskie.enable = true;
          };
        }
      ];
    };
  };
}
