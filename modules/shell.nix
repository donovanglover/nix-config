{ pkgs, config, lib, ... }:

let
  inherit (pkgs) fish;
  inherit (lib) mkEnableOption mkIf mkMerge singleton;
  inherit (builtins) attrValues;
  inherit (cfg) postgres;
  inherit (config.modules.system) username;

  cfg = config.modules.shell;
in
{
  options.modules.shell = {
    postgres = mkEnableOption "postgres database and pgcli for containers";
  };

  config = {
    users.defaultUserShell = fish;
    environment.shells = [ fish ];

    environment.sessionVariables = {
      GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
      FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
      NODE_OPTIONS = "--max_old_space_size=16384";
      BAT_THEME = "base16";
      GATSBY_TELEMETRY_DISABLED = "1";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    environment.systemPackages = mkMerge [
      (attrValues {
        inherit (pkgs)
          wget
          jq
          eza
          fd
          fzf
          ripgrep
          file
          timg
          choose
          sd
          ;
        inherit (pkgs)
          treefmt
          httpie
          yt-dlp
          sox
          dig
          mtr
          mediainfo
          fdupes
          whois
          killall
          trashy
          hwinfo
          stress
          hdparm
          recode
          rmlint
          jpegoptim
          watchexec
          zola
          pass
          ;
        inherit (pkgs)
          sudachi-rs
          tango
          ;
        inherit (pkgs)
          neofetch
          onefetch
          scc
          genact
          dwt1-shell-color-scripts
          colorpanes
          sanctity
          cmatrix
          ;
        inherit (pkgs)
          gdu
          hexyl
          visidata
          zellij
          diskonaut
          ;
        inherit (pkgs)
          p7zip
          unar
          rsync
          rclone
          ffmpeg
          imagemagick
          smartmontools
          restic
          zbar
          lychee
          ventoy
          ;
        inherit (pkgs)
          nixpkgs-review
          nix-init
          nvd
          nix-search-cli
          ;
      })

      (mkIf postgres (attrValues {
        inherit (pkgs) pgcli;
      }))
    ];

    services.postgresql = mkIf postgres {
      enable = true;

      ensureUsers = singleton {
        name = username;
      };

      ensureDatabases = [ username ];
    };

    programs = {
      fish.enable = true;
      neovim.enable = true;
      direnv.enable = true;
    };
  };
}
