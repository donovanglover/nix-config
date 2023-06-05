{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
      restrictNetwork = true;
    };

    virtualisation.qemu.options =
      [ "-device virtio-vga-gl" "-display sdl,gl=on,show-cursor=off" "-full-screen" ];

    environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
    };
  };
}
