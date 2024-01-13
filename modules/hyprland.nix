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

  security.pam.services.swaylock = { };

  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  services.xserver = {
    enable = true;
    excludePackages = [ pkgs.xterm ];
  };
}
