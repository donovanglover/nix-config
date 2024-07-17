{ self, pkgs, lib, ... }:

let
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
      eza
      fish
      git
      gpg
      gtk
      htop
      kitty
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
      programs.man.generateCaches = lib.mkForce false;
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
      gnome-console
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

  hardware.graphics.enable32Bit = lib.mkForce false;
  virtualisation.virtualbox.host.enable = lib.mkForce false;

  programs = {
    calls.enable = true;
    cdemu.enable = lib.mkForce false;
  };

  services.pipewire.enable = lib.mkForce false;
  boot.enableContainers = false;

  networking = {
    wireless.enable = false;
    wireguard.enable = true;
  };

  services = {
    openssh.enable = true;
    udisks2.enable = lib.mkForce false;
  };

  boot.binfmt.emulatedSystems = lib.mkForce [ ];
  boot.loader.systemd-boot.enable = lib.mkForce false;
  networking.firewall.checkReversePath = lib.mkForce false;
  documentation.man.generateCaches = false;

  powerManagement = {
    enable = true;

    cpufreq = rec {
      min = 648000;
      max = min;
    };

    cpuFreqGovernor = "powersave";
  };
}
