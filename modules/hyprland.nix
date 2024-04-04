{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  i18n.inputMethod = {
    enabled = "fcitx5";

    fcitx5 = {
      addons = with pkgs; [ fcitx5-mozc ];
      waylandFrontend = true;
    };
  };

  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
  };

  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pulseaudio
  ];

  services.greetd = {
    enable = true;
    restart = false;

    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd Hyprland";
        user = "greeter";
      };

      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "user";
      };
    };
  };
}
