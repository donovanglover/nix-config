{
  home-manager.sharedModules = [{
    xdg.configFile."xfce4/helpers.rc".text = ''
      TerminalEmulator=kitty
      TerminalEmulatorDismissed=true
    '';
  }];
}
