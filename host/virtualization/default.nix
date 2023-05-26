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

    services.xserver.displayManager.autoLogin.enable = true;
    services.xserver.displayManager.autoLogin.user = "user";
    systemd.services."getty@tty1".enable = false;
    systemd.services."autovt@tty1".enable = false;

    i18n.inputMethod = lib.mkDefault {
      enabled = "ibus";
      ibus.engines = with pkgs.ibus-engines; [ mozc ];
    };

    services.gnome.core-utilities.enable = false;
    environment.gnome.excludePackages = [ pkgs.gnome-tour ];

    services.pipewire.enable = lib.mkForce false;
    services.mullvad-vpn.enable = lib.mkForce false;
    programs.hyprland.enable = lib.mkForce false;
    services.greetd.enable = lib.mkForce false;
  };
}
