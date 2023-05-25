{ pkgs, ... }:

{
  imports = [
    ./user
  ];

  # locale
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales =
    [ "en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8" ];

  # nix
  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  # home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [{
      home.stateVersion = "22.11";
    }];
  };

  # systemd
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # timezone
  time.timeZone = "America/New_York";
}
