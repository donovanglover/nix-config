{ lib, ... }:

{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096;
      cores = 4;
    };

    virtualisation.qemu.options = [
      "-device virtio-vga-gl"
      "-display sdl,gl=on,show-cursor=off"
      "-audio pa,model=hda"
    ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };

    services.interception-tools.enable = lib.mkForce false;
    networking.resolvconf.enable = lib.mkForce true;

    boot.enableContainers = false;
  };
}
