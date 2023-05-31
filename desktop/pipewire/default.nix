{
  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;

    lowLatency.enable = true;
  };

  security.rtkit.enable = true;
}
