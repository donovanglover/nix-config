{ self, pkgs, lib, ... }:

let
  inherit (self.packages.${pkgs.system}) aleo-fonts;
  inherit (pkgs) phinger-cursors noto-fonts-cjk-sans maple-mono noto-fonts-emoji;
  inherit (lib) singleton;
  inherit (builtins) attrValues;

  username = "user";
  theme = "monokai";
  fontSize = 11;
  stateVersion = "23.11";
in
{
  imports = attrValues {
    inherit (self.inputs.home-manager.nixosModules) home-manager;
    inherit (self.inputs.stylix.nixosModules) stylix;
  };

  nixpkgs.overlays = attrValues self.overlays;

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = attrValues self.homeManagerModules ++ singleton {
      home = {
        inherit stateVersion;
      };

      programs.man.generateCaches = true;
    };

    users.${username}.home = {
      inherit username;

      homeDirectory = "/home/${username}";
    };
  };

  programs.thunar = {
    enable = true;

    plugins = attrValues {
      inherit (pkgs.xfce) thunar-volman;
    };
  };

  services.tumbler.enable = true;

  fonts = {
    enableDefaultPackages = false;

    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-emoji
      maple-mono
      font-awesome
      (nerdfonts.override { fonts = [ "Noto" ]; })
      kanji-stroke-order-font
      liberation_ttf
      aleo-fonts
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "Noto Serif CJK JP" "Noto Serif" ];
        sansSerif = [ "Noto Sans CJK JP" "Noto Sans" ];
        monospace = [ "Noto Sans Mono CJK JP" "Noto Sans Mono" ];
      };

      allowBitmaps = false;
    };
  };

  stylix = {
    image = ../assets/wallpaper.png;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

    opacity = {
      terminal = 0.95;
      popups = 0.95;
    };

    cursor = {
      package = phinger-cursors;
      name = "phinger-cursors";
      size = 24;
    };

    fonts = {
      serif = {
        package = aleo-fonts;
        name = "Aleo";
      };

      sansSerif = {
        package = noto-fonts-cjk-sans;
        name = "Noto Sans CJK JP";
      };

      monospace = {
        package = maple-mono;
        name = "Maple Mono";
      };

      emoji = {
        package = noto-fonts-emoji;
        name = "Noto Color Emoji";
      };

      sizes = {
        applications = fontSize;
        desktop = fontSize;
        popups = fontSize;
        terminal = fontSize;
      };
    };
  };

  environment = {
    sessionVariables = {
      LIBGL_ALWAYS_SOFTWARE = "true";
    };

    shells = with pkgs; [
      fish
    ];

    systemPackages = with pkgs; [
      flare-signal
      gurk-rs
      anki
      android-tools
      wget
      chatty
      gnome-console
      megapixels
      kitty
      neovim
      fish
      yazi
      bat
      w3m
      librewolf
      git
      htop-vim
      gnupg
      mpv
      ncmpcpp
      pqiv
      qutebrowser
      starship
      eza
      fd
      fzf
      ripgrep
      yt-dlp
      neofetch
      genact
      zellij
      p7zip
      unar
    ];

    defaultPackages = [ ];
  };

  programs = {
    fish.enable = true;
    neovim.enable = true;
    calls.enable = true;
    command-not-found.enable = false;
  };

  networking = {
    hostName = "mobile-nixos";
    wireless.enable = false;
    wireguard.enable = true;

    networkmanager = {
      enable = true;
      wifi.macAddress = "random";
      ethernet.macAddress = "random";
    };
  };

  services = {
    openssh.enable = true;
    resolved.llmnr = "false";

    xserver.desktopManager.phosh = {
      enable = true;
      group = "users";
      user = username;
    };
  };

  users = {
    defaultUserShell = pkgs.fish;

    users.${username} = {
      isNormalUser = true;
      description = username;
      password = username;

      extraGroups = [
        "dialout"
        "feedbackd"
        "networkmanager"
        "video"
        "wheel"
      ];
    };
  };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 4096;
      cores = 4;

      sharedDirectories = {
        tmp = {
          source = "/tmp";
          target = "/mnt";
        };
      };

      qemu.options = [
        "-device virtio-vga-gl"
        "-display sdl,gl=on,show-cursor=off"
        "-audio pa,model=hda"
        "-full-screen"
      ];
    };
  };

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      auto-optimise-store = true;
      warn-dirty = false;

      trusted-users = [
        "root"
        "@wheel"
      ];
    };
  };

  powerManagement.enable = true;
  zramSwap.enable = true;

  system = {
    inherit stateVersion;
  };
}
