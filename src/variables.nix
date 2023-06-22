{
  hostname = "nixos";
  system = "x86_64-linux";
  hostHardwareConfiguration = ../hardware/laptop.nix;
  stateVersion = "22.11";
  username = "user";
  defaultBrowser = "librewolf";
}
