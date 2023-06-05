{ pkgs, lib, hypr-contrib, nix-gaming, ... }:

{
  imports = [
    ./modules
    ./desktop
    ./dev
    ./host
    ./containers/rar.nix
    ./containers/wine.nix
  ];

  # locale
  i18n.defaultLocale = "ja_JP.UTF-8";
  i18n.supportedLocales =
    [ "ja_JP.UTF-8/UTF-8" "en_US.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8" ];

  # nix
  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
    };
  };

  hardware.opengl.driSupport32Bit = true;

  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
    };

    timeout = 0;
    efi.canTouchEfiVariables = true;
  };

  boot.tmp.useTmpfs = true;

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    hypr-contrib.packages."x86_64-linux".grimblast
    nix-gaming.packages."x86_64-linux".osu-stable
    (pkgs.callPackage ./packages/waycorner { })
    (pkgs.callPackage ./packages/srb2 { })
    slade
    typespeed
    osu-lazer-bin

    # dev
    marksman
    lua-language-server
    clang-tools
    texlab

    # go
    go
    gopls

    # nix
    nil
    nixfmt
    nixos-generators

    # node/yarn/deno
    nodejs
    yarn
    deno

    # rust
    gcc
    rustc
    rustfmt
    cargo
    rust-analyzer
    bacon
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "osu-lazer-bin"
    "vmware-workstation"
  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
    FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
    NODE_OPTIONS = "--max_old_space_size=16384";
  };

  environment.defaultPackages = [ ];
  system.stateVersion = "22.11";

  # home-manager
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [{
      home.stateVersion = "22.11";

      editorconfig = {
        enable = true;

        settings = {
          "*" = {
            charset = "utf-8";
            end_of_line = "lf";
            insert_final_newline = true;
            indent_size = 2;
            indent_style = "space";
            trim_trailing_whitespace = true;
          };

          "*.md".indent_style = "tab";

          "Makefile" = {
            indent_style = "tab";
            indent_size = 4;
          };

          "*.html" = {
            indent_style = "tab";
            indent_size = 4;
          };

          "*.go" = {
            indent_style = "tab";
            indent_size = 4;
          };
        };
      };
    }];
  };

  # systemd
  systemd.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';

  # logind
  services.logind.lidSwitch = "ignore";

  # timezone
  time.timeZone = "America/New_York";

  # user
  users = {
    mutableUsers = false;

    users.user = {
      isNormalUser = true;
      uid = 1000;
      password = "user";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  home-manager.users.user = {
    home.username = "user";
    home.homeDirectory = "/home/user";
  };

  # dev
  programs.npm.enable = true;
}
