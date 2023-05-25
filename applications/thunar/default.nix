{ pkgs, ... }:

{
  programs.thunar.enable = true;
  services.tumbler.enable = true; # Thumbnail support
  environment.systemPackages = [ pkgs.xfce.exo ]; # Open with kitty support
  services.gvfs.enable = true; # Trash support

  home-manager.sharedModules = [{
    xdg.configFile."xfce4/helpers.rc".text = ''
      TerminalEmulator=kitty
      TerminalEmulatorDismissed=true
    '';
  }];
}
