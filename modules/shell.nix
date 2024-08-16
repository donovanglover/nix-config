{ pkgs, ... }:

let
  inherit (pkgs) fish;
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

    systemPackages = with pkgs; [
      jq
      eza
      fd
      fzf
      ripgrep
      xh
      file
      timg
      choose
      sd
      rustscan
      treefmt
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
      fastfetch
      onefetch
      scc
      genact
      dwt1-shell-color-scripts
      colorpanes
      sanctity
      cmatrix
      gdu
      hexyl
      diskonaut
      pgcli
      litecli
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
      nixpkgs-review
      nix-update
      statix
      nvd
      nix-search-cli
      nix-tree
      rustc
      rustfmt
      cargo
      cargo-tarpaulin
      bacon
      clippy
      nodejs
      deno
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
