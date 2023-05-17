{ pkgs, ... }:

{
  programs.thunar.enable = true;
  services.tumbler.enable = true;
  environment.systemPackages = [ pkgs.xfce.exo ];

  home-manager.sharedModules = [{
    xdg.configFile."xfce4/helpers.rc".text = ''
      TerminalEmulator=kitty
      TerminalEmulatorDismissed=true
    '';
  }];
}
