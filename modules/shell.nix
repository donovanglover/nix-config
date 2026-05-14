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
      p7zip
      unar
      rsync
      rclone
      megacmd
      ffmpeg
      imagemagick
      smartmontools
      restic
      zbar
      phraze
      lychee
      bluetui
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
      arion
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
      unflac
      openai-whisper
      zizmor
      go-grip
      eclint
      editorconfig-checker
      signal-cli
      typos
      gallery-dl
      hydra-check
      awscli2
      mkbrr
      poppler-utils
      dejsonlz4
      gdb
      bun
      json2yaml
      gemini-cli
      opencode
      sqlit-tui
      silverbullet
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
