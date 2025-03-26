{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.fish;

  environment = {
    shells = with pkgs; [
      fish
    ];

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
      jpegoptim
      pass
      tango
      npm-check-updates
      microfetch
      onefetch
      scc
      genact
      sanctity
      asciiquarium-transparent
      cmatrix
      gdu
      hexyl
      pgcli
      litecli
      p7zip
      unar
      rsync
      rclone
      megacmd
      ffmpeg
      imagemagick
      smartmontools
      restic
      borgbackup
      zbar
      phraze
      lychee
      bluetui
      ventoy
      nixpkgs-review
      nix-init
      nix-update
      statix
      nvd
      nix-search-cli
      nix-tree
      gcc
      rustc
      rustfmt
      cargo
      cargo-tarpaulin
      bacon
      clippy
      nodejs
      monolith
      haylxon
      nix-inspect
      sherlock
      remind
      oxipng
      lazydocker
      tabiew
      viddy
      jless
      rclip
      exiftool
      xsubfind3r
      all-the-package-names
      pik
      bottom
      pdfminer
      dos2unix
      clock-rs
      taskwarrior3
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
