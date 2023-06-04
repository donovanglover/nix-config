{
  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };

    virtualisation.qemu.options =
      [ "-device virtio-vga-gl" "-display sdl,gl=on" ];
  };
}
