{ pkgs, ... }:

let
  inherit (pkgs.nixVersions) nix_2_19;

  # TODO: Make these variables options
  timeZone = "America/New_York";
  defaultLocale = "ja_JP.UTF-8";
  supportedLocales = [ "ja_JP.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8" ];
  stateVersion = "22.11";
in
{
  boot = {
    tmp.cleanOnBoot = true;

    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        configurationLimit = 10;
      };

      timeout = 0;
      efi.canTouchEfiVariables = true;
    };
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

  zramSwap = {
    enable = true;
    memoryPercent = 100;
  };

  time = {
    inherit timeZone;
  };

  i18n = {
    inherit defaultLocale supportedLocales;
  };

  system = {
    inherit stateVersion;
  };
}
