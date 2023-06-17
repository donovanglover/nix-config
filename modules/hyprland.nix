{ pkgs, ... }:

{
  programs.hyprland.enable = true;

  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };

  environment.systemPackages = with pkgs; [
    polkit_gnome
  ];

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
    excludePackages = [ pkgs.xterm ];
  };
}
