{ pkgs, ... }:

{
  home.packages = with pkgs; [
    icoextract
    thud
    xapp-thumbnailers
  ];

  xdg.configFile."xfce4/helpers.rc".text = # ini
    ''
      TerminalEmulator=kitty
      TerminalEmulatorDismissed=true
    '';
}
