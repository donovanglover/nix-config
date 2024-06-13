{ pkgs, ... }:

{
  networking = {
    hostName = "mobile-nixos";
    wireless.enable = false;
    networkmanager.enable = true;
  };

  hardware = {
    pulseaudio = {
      enable = true;
      package = pkgs.pulseaudioFull;
    };

    bluetooth.enable = true;
  };

  powerManagement.enable = true;

  zramSwap.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" "repl-flake" ];

  services.xserver.desktopManager.phosh = {
    user = "user";
  };

  users.users."user" = {
    isNormalUser = true;
    description = "User";
    password = "user";
    extraGroups = [
      "dialout"
      "feedbackd"
      "networkmanager"
      "video"
      "wheel"
    ];
  };

  system.stateVersion = "23.11";
}
