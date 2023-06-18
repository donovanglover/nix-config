{ pkgs, ... }: {
  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;

    # lowLatency.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pulseaudio
  ];

  security.rtkit.enable = true;
}
