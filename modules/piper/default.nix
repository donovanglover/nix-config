{pkgs, ...}: {
  services.ratbagd.enable = true;

  environment.systemPackages = [pkgs.piper];
}
