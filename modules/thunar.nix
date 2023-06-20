{ pkgs, ... }: {
  programs.thunar.enable = true;
  services.tumbler.enable = true; # Thumbnail support
  programs.thunar.plugins = with pkgs.xfce; [ thunar-volman ];

  environment.systemPackages = with pkgs; [
    xfce.exo # Open with kitty support
    glib
  ];

  services.gvfs.enable = true; # Trash support
  services.gnome.gnome-keyring.enable = true; # Mount support
}
