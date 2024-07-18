{ self, pkgs, lib, ... }:

let
  inherit (lib) mkForce;
  inherit (builtins) attrValues;
in
{
  imports = attrValues self.nixosModules;

  nixpkgs.overlays = attrValues {
    inherit (self.overlays)
      phinger-cursors
      ;
  };

  home-manager.sharedModules = attrValues {
    inherit (self.homeManagerModules)
      alacritty
      eza
      fish
      git
      gpg
      gtk
      htop
      librewolf
      mpv
      ncmpcpp
      neovim
      starship
      thunar
      xdg-user-dirs
      xresources
      ;

    config = {
      programs.man.generateCaches = mkForce false;

      dconf.settings = {
        "sm/puri/phosh/lockscreen" = {
          shuffle-keypad = true;
        };
      };
    };
  };

  environment.systemPackages = attrValues {
    inherit (self.packages.${pkgs.system})
      webp-thumbnailer
      ;
    inherit (pkgs.gnome)
      gnome-contacts
      gnome-sound-recorder
      gnome-maps
      ;

    inherit (pkgs)
      gurk-rs
      android-tools
      chatty
      megapixels
      fractal
      g4music
      livi
      papers
      phosh-mobile-settings
      resources
      tuba
      caerbannog
      eog
      geary
    ;
  };

  modules = {
    system = {
      hostName = "mobile-nixos";
      stateVersion = "23.11";
      mullvad = true;
    };

    hardware.keyboardBinds = true;
  };

  programs = {
    calls.enable = true;

    cdemu.enable = mkForce false;
  };


  networking = {
    wireless.enable = false;
    wireguard.enable = true;

    firewall.checkReversePath = mkForce false;
  };

  services = {
    openssh.enable = true;

    udisks2.enable = mkForce false;
    pipewire.enable = mkForce false;
  };

  boot = {
    enableContainers = false;

    binfmt.emulatedSystems = mkForce [ ];
    loader.systemd-boot.enable = mkForce false;
  };

  documentation.man.generateCaches = false;

  hardware.graphics.enable32Bit = mkForce false;
  virtualisation.virtualbox.host.enable = mkForce false;

  powerManagement = {
    enable = true;

    cpufreq = rec {
      min = 648000;
      max = min;
    };

    cpuFreqGovernor = "powersave";
  };
}
