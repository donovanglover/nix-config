{
  virtualisation = {
    memorySize = 8192;
    cores = 4;

    sharedDirectories = {
      testing = {
        source = "/home/user/containers/testing";
        target = "/mnt";
      };
    };
  };

  virtualisation.qemu.options = [
    "-device virtio-vga-gl"
    "-display sdl,gl=on,show-cursor=off"
    "-full-screen"
    "-audio pa,model=hda"
  ];

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
  };
}
