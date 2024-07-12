{ nix-config, ... }:

let
  inherit (builtins) attrValues;
in
{
  imports = attrValues {
    inherit (nix-config.nixosModules)
      shell
      desktop
      system
      ;
  };

  home-manager.sharedModules = attrValues {
    inherit (nix-config.homeManagerModules)
      fish
      git
      gtk
      kitty
      neovim
      xresources
      yazi
      ;
  };

  nixpkgs.overlays = attrValues nix-config.overlays;

  modules = {
    desktop.container = true;
    system.noRoot = true;
  };

  environment = {
    variables = {
      TERM = "xterm-kitty";
    };

    sessionVariables = {
      WAYLAND_DISPLAY = "wayland-1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_RUNTIME_DIR = "/run/user/1000";
      DISPLAY = ":0";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";
    };
  };

  hardware.graphics.enable = true;
}
