{
  nix-config,
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (nix-config.inputs.sakaya.packages.${pkgs.system}) sakaya;
  inherit (config.modules.system) username;
  inherit (lib) singleton getExe;

  sakayaPort = 39493;
in
{
  imports = with nix-config.nixosModules; [
    shell
    desktop
    system
    stylix
    fonts
  ];

  home-manager.sharedModules = with nix-config.homeModules; [
    fish
    git
    gtk
    kitty
    neovim
    xresources
    yazi
  ];

  nixpkgs.overlays = builtins.attrValues nix-config.overlays;

  environment = {
    systemPackages =
      (with pkgs; [
        wineWowPackages.waylandFull
        winetricks
      ])
      ++ [ sakaya ];

    variables = {
      TERM = "xterm-kitty";
    };

    sessionVariables = {
      WAYLAND_DISPLAY = "wayland-1";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      XDG_RUNTIME_DIR = "/run/user/1000";
      DISPLAY = ":0";
      QT_IM_MODULE = "fcitx";
      XMODIFIERS = "@im=fcitx";
      SDL_IM_MODULE = "fcitx";
      GLFW_IM_MODULE = "ibus";
      LC_ALL = "ja_JP.UTF-8";
      TZ = "Asia/Tokyo";
    };
  };

  hardware.graphics.enable = true;

  networking = {
    nat.forwardPorts = singleton {
      destination = "192.168.100.49:${sakayaPort}";
      sourcePort = sakayaPort;
    };

    firewall.allowedTCPPorts = [ sakayaPort ];
  };

  systemd.services.sakaya = {
    enable = true;
    description = "sakaya server";

    unitConfig = {
      Type = "simple";
    };

    path = with pkgs; [ su ];

    serviceConfig = {
      ExecStart = "/usr/bin/env su ${username} --command=${getExe sakaya}";
    };

    wantedBy = [ "multi-user.target" ];
  };
}
