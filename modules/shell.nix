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
      NODE_OPTIONS = "--max-old-space-size=16384";
      BAT_THEME = "base16";
      GATSBY_TELEMETRY_DISABLED = "1";
    };

    systemPackages = with pkgs; [
      jq
      fd
      xh
      file
      timg
      choose
      sd
      rustscan
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
      duf
      stress
      hdparm
      recode
      rmlint
      jpegoptim
      pass
      sudachi-rs
      tango
      npm-check-updates
      microfetch
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
