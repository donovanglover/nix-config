{ pkgs, lib, ... }:

let
  inherit (pkgs) fish;
  inherit (lib) mkMerge;
  inherit (builtins) attrValues;
in
{
  users.defaultUserShell = fish;

  environment = {
    shells = [ fish ];

    sessionVariables = {
      GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
      FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
      NODE_OPTIONS = "--max-old-space-size=16384";
      BAT_THEME = "base16";
      GATSBY_TELEMETRY_DISABLED = "1";
    };

    systemPackages = mkMerge [
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
          asak
          timer
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
          pass
          sudachi-rs
          tango
          npm-check-updates
          ;
        inherit (pkgs)
          fastfetch
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
          zellij
          diskonaut
          pgcli
          litecli
          iamb
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
          borgbackup
          zbar
          phraze
          lychee
          ventoy
          taskwarrior3
          ;
        inherit (pkgs)
          nixpkgs-review
          nix-init
          statix
          nvd
          nix-search-cli
          nix-tree
          ;
        inherit (pkgs)
          rustc
          rustfmt
          cargo
          cargo-tarpaulin
          bacon
          clippy
          nodejs
          deno
          tectonic
          ;
      })
    ];
  };

  programs = {
    fish.enable = true;
    neovim.enable = true;

    direnv = {
      enable = true;
      silent = true;
    };
  };
}
