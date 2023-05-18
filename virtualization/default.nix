{ pkgs, lib, ... }:

{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };

    virtualisation.qemu.options =
      [ "-device virtio-vga-gl" "-display sdl,gl=on" ];

    services.xserver.desktopManager.gnome.enable = true;
    services.xserver.displayManager.gdm.enable = true;

    i18n.inputMethod = lib.mkDefault {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ mozc ];
    };

    services.gnome.core-utilities.enable = false;
    environment.gnome.excludePackages = [ pkgs.gnome-tour ];
    hardware.pulseaudio.enable = false;
  };
}
