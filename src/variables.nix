{
  hostname = "nixos";
  system = "x86_64-linux";
  timezone = "America/New_York";
  hostHardwareConfiguration = ../hosts/laptop.nix;
  stateVersion = "22.11";
  defaultLocale = "ja_JP.UTF-8";
  supportedLocales = ["ja_JP.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8"];
  username = "user";
}
