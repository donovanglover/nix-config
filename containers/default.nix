{ stylix
, home-manager
, sakaya
, ...
}:

let
  template = {
    privateNetwork = true;
    ephemeral = true;
    autoStart = true;
    restartIfChanged = false;

    bindMounts = {
      "/mnt" = {
        hostPath = "/home/user/containers/wine";
        isReadOnly = false;
      };

      waylandDisplay = rec {
        hostPath = "/run/user/1000";
        mountPoint = hostPath;
      };

      x11Display = rec {
        hostPath = "/tmp/.X11-unix";
        mountPoint = hostPath;
      };

      dri = rec {
        hostPath = "/dev/dri";
        mountPoint = hostPath;
      };
    };

    allowedDevices = [
      {
        modifier = "rw";
        node = "/dev/dri/renderD128";
      }
    ];
  };
in
{
  systemd.tmpfiles.rules = [
    "d /run/user/1000 0700 user users -"
  ];

  containers.wine = template // {
    hostAddress = "192.168.100.34";
    localAddress = "192.168.100.49";

    config = { lib, pkgs, ... }: {
      imports = [
        stylix.nixosModules.stylix
        home-manager.nixosModules.home-manager
        ./shared.nix
      ];

      networking.nat.forwardPorts = [
        {
          destination = "192.168.100.49:39493";
          sourcePort = 39493;
        }
        {
          destination = "192.168.100.49:5029";
          sourcePort = 5029;
        }
      ];

      networking.firewall.allowedTCPPorts = [
        39493
        5029
      ];

      systemd.services.sakaya = {
        enable = true;
        description = "sakaya server";

        unitConfig = {
          Type = "simple";
        };

        path = with pkgs; [
          su
        ];

        serviceConfig = {
          ExecStart = "/usr/bin/env su user --command=${sakaya.packages.${pkgs.system}.sakaya}/bin/sakaya";
        };

        wantedBy = [ "multi-user.target" ];
      };

      environment.systemPackages = with pkgs; [
        wineWowPackages.waylandFull
        winetricks
        sakaya.packages.${system}.sakaya
        rar
        unrar
        iamb
        srb2
      ];

      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "rar"
        "unrar"
      ];

      environment.sessionVariables = {
        LC_ALL = "ja_JP.UTF-8";
        TZ = "Asia/Tokyo";
      };
    };
  };
}
