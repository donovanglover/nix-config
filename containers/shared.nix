{
  imports = [
    ../modules/shell.nix
    ../modules/desktop.nix
    ../modules/system.nix
  ];

  home-manager.sharedModules = [
    ../home/fish.nix
    ../home/git.nix
    ../home/gtk.nix
    ../home/kitty.nix
    ../home/neovim.nix
    ../home/xcursor.nix
    ../home/xresources.nix
    ../home/yazi.nix
  ];

  modules = {
    desktop.container = true;
    system.noRoot = true;
  };

  environment = {
    defaultPackages = [ ];
    variables.TERM = "xterm-kitty";

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

  hardware.opengl.enable = true;
}
