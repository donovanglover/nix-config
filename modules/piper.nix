{ pkgs, ... }:

{
  services.ratbagd.enable = true;

  environment.systemPackages = [ pkgs.piper ];

  services.udev.extraRules = ''
    KERNEL=="event*", ATTRS{name}=="AT Translated Set 2 keyboard", ENV{LIBINPUT_IGNORE_DEVICE}="1"
  '';
}
