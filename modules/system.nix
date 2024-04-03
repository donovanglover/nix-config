{ pkgs, ... }:

let
  inherit (pkgs.nixVersions) nix_2_19;
in
{
  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
      configurationLimit = 10;
    };

    timeout = 0;
    efi.canTouchEfiVariables = true;
  };

  systemd = {
    extraConfig = "DefaultTimeoutStopSec=10s";
    services.NetworkManager-wait-online.enable = false;
  };

  nix = {
    package = nix_2_19;

    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      auto-optimise-store = true;
      warn-dirty = false;
    };
  };

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.supportedLocales = [ "ja_JP.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8" ];

  system.stateVersion = "22.11";
}
