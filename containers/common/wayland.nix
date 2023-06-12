{
  environment.sessionVariables = {
    WAYLAND_DISPLAY = "wayland-1";
    QT_QPA_PLATFORM = "wayland";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    MOZ_ENABLE_WAYLAND = "1";
    XDG_RUNTIME_DIR = "/run/user/1000";
    DISPLAY = ":0";
  };

  services.xserver.enable = true;

  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };
}
