{
  virtualisation.vmware.host = {
    enable = true;
    extraConfig = /* config */ ''
      # Enable 3D acceleration on the host
      mks.gl.allowUnsupportedDrivers = "TRUE"
      mks.vk.allowUnsupportedDevices = "TRUE"
    '';
  };
}
