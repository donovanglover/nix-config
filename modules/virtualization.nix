{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;

      sharedDirectories = {
        home = {
          source = "$HOME";
          target = "/mnt";
        };
      };
    };

    virtualisation.qemu.options = [
      "-device virtio-vga-gl"
      "-display sdl,gl=on,show-cursor=off"
      "-audio pa,model=hda"
    ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
