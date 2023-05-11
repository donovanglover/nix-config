{ config, pkgs, lib, stylix, ... }:

{
  imports = [ ./hosts/laptop.nix ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  services.xserver.displayManager.lightdm.enable = false;

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [ "interface-name:ve-*" ];
  networking.networkmanager.dns = "none";
  networking.useHostResolvConf = true;
  services.udisks2.enable = true;
  security.pam.services.swaylock = { };

  virtualisation.vmVariant = {
    virtualisation = {
      memorySize = 8192;
      cores = 4;
    };
    virtualisation.qemu.options =
      [ "-device virtio-vga-gl" "-display gtk,gl=on" ];
  };

  stylix.image = ./wallpaper.png;
  stylix.polarity = "dark";
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";

  stylix.fonts = {
    serif = {
      package = pkgs.noto-fonts-cjk-sans;
      name = "Noto Sans CJK JP";
    };

    sansSerif = {
      package = pkgs.noto-fonts-cjk-sans;
      name = "Noto Sans CJK JP";
    };

    monospace = {
      package = pkgs.maple-mono-NF;
      name = "MapleMono-NF";
    };

    emoji = {
      package = pkgs.noto-fonts-emoji;
      name = "Noto Color Emoji";
    };

    sizes = {
      applications = 11;
      desktop = 11;
      popups = 11;
      terminal = 11;
    };
  };

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
    FZF_DEFAULT_COMMAND = "rg --files --no-ignore --hidden --follow --glob \"!.git/*\"";
    FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
    NODE_OPTIONS = "--max_old_space_size=16384";
  };

  services.vnstat.enable = true;
  services.tumbler.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.fish.enable = true;
  users.defaultUserShell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];
  programs.fish.shellAliases = {
    ls = "exa --group-directories-first -I 'lost+found'";
    tree = "exa --group-directories-first --all --long --tree -I 'node_modules|.git|public|lost+found'";
    mv = "mv -i";
    rg = "rg --max-columns=2000";
  };
  programs.fish.shellAbbrs = {
    g = "git";
    ga = "git add";
    gaa = "git add --all";
    gap = "git add --patch";
    gb = "git branch"; # List all branches
    gc = "git commit -m";
    gca = "git commit --amend";
    gcl = "git clone";
    gco = "git checkout";
    gd = "git diff"; # Show all file changes not staged yet
    gdi = "git difftool --no-symlinks --dir-diff";
    gds = "git diff --staged"; # Show changes staged but not committed
    gdsi = "git difftool --no-symlinks --dir-diff --staged";
    gi = "git init";
    gl = "git log --oneline --decorate --all --graph -n 10";
    gm = "git merge";
    gp = "git push"; # Push your commits to a remote server
    gr = "git reset HEAD~"; # Undo the last commit but keep changed files
    gra = "git remote add";
    gre = "git remote --verbose"; # List all remotes
    grh = "git reset HEAD";
    grr =
      "git reset --hard HEAD~"; # Remove the last commit and all changes with it
    gs = "git status";
    gst = "git stash";
    gstp = "git stash pop";
    gt = "git tag";
    gts = "git tag -s";

    d = "sudo docker";
    dc = "sudo docker-compose";
    dcu = "sudo docker-compose up";
    dcd = "sudo docker-compose down";
    dcp = "sudo docker-compose pull";
    dcl = "sudo docker-compose logs";

    y = "yarn";
    ya = "yarn add";
    yar = "yarn remove";
    yi = "yarn init";
    yin = "yarn install";
    yu = "yarn upgrade-interactive";

    v = "vagrant";
    vu = "vagrant up";
    vh = "vagrant halt";
    vs = "vagrant ssh";
    vp = "vagrant provision";

    dl = "yt-dlp";
    vol =
      "wpctl set-volume '@DEFAULT_AUDIO_SINK@'"; # Change the volume, e.g. vol 10%+, vol 10%-, vol 100%
    cf = "tput reset"; # Clear the terminal completely
    nf = "tput reset; and neofetch --size 56%";
    df = "df --human-readable --type=ext4 --total";
    du = "du --human-readable --summarize";
    jis =
      "recode shift_jis..utf8"; # Easily convert shift_jis-encoded files to utf8
    utf16 =
      "recode utf16..utf8"; # Rarely, some files from Japan are utf16 instead
    jp = "LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8";

    a = "ansible-playbook";
    b = "swaybg -m fill -i"; # Change the background
    c = "clear"; # Because 5 letters is too much
    e = "exit";
    k = "kitty @ set-colors -c -a ~/.cache/wal/kitty";
    l = "ls -l";
    r = "ranger";
    w = "wal -o ~/.config/wal/done.sh";
    T = "tree";
  };

  time.timeZone = "America/New_York";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales =
    [ "en_US.UTF-8/UTF-8" "ja_JP.UTF-8/UTF-8" "fr_FR.UTF-8/UTF-8" ];

  services.xserver.enable = true;
  programs.thunar.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;
      directory = {
        style = "purple";
        read_only = " ro";
      };

      git_branch = {
        style = "yellow";
        symbol = "";
      };

      character = {
        success_symbol = "[>](red)[>](green)[>](blue)";
        error_symbol = "[>](cyan)[>](purple)[>](yellow)";
        vicmd_symbol = "[<](bold green)";
      };

      line_break = { disabled = true; };

      nodejs = {
        format = "with [$symbol($version )]($style)";
        symbol = "node ";
        version_format = "\${major}";
        disabled = true;
      };

      git_commit.tag_symbol = " tag ";
      git_status = {
        ahead = ">";
        behind = "<";
        diverged = "<>";
        renamed = "r";
        deleted = "x";
      };

      aws.symbol = "aws ";
      cobol.symbol = "cobol ";
      conda.symbol = "conda ";
      crystal.symbol = "cr ";
      cmake.symbol = "cmake ";
      dart.symbol = "dart ";
      deno.symbol = "deno ";
      dotnet.symbol = ".NET ";
      docker_context.symbol = "docker ";
      elixir.symbol = "exs ";
      elm.symbol = "elm ";
      golang.symbol = "go ";
      hg_branch.symbol = "hg ";
      java.symbol = "java ";
      julia.symbol = "jl ";
      kotlin.symbol = "kt ";
      memory_usage.symbol = "memory ";
      nim.symbol = "nim ";
      nix_shell.symbol = "nix ";
      ocaml.symbol = "ml ";
      package.symbol = "pkg ";
      perl.symbol = "pl ";
      php.symbol = "php ";
      purescript.symbol = "purs ";
      python.symbol = "python ";
      ruby.symbol = "ruby ";
      rust.symbol = "rust ";
      scala.symbol = "scala ";
      swift.symbol = "swift ";
    };
  };
  programs.neovim.enable = true;
  programs.git.enable = true;
  programs.firejail.enable = true;

  nix.package = pkgs.nixFlakes;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    fluent-icon-theme
    fluent-gtk-theme
    maple-mono-NF
    tmux
    fish
    wget
    grim
    slurp
    librewolf
    kitty
    mullvad-vpn
    mullvad-browser
    papirus-icon-theme
    mediainfo
    pywal
    mpv
    neofetch
    anki
    logseq
    wl-clipboard
    sox
    spek
    ripgrep
    rsync
    jq
    keepassxc
    feh
    stow
    lf
    exa
    fd
    fzf
    unar
    gdu
    ranger
    nixfmt
    whois
    wofi
    rofi-wayland
    tig
    diff-so-fancy
    trashy
    swaybg
    udiskie
    brightnessctl
    killall
  ];

  fonts.enableDefaultFonts = true;
  fonts.fonts = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts-emoji
    hack-font
    maple-mono-NF
  ];

  fonts.fontconfig = {
    defaultFonts = {
      serif = [ "Noto Serif CJK JP" "Noto Serif" ];
      sansSerif = [ "Noto Sans CJK JP" "Noto Sans" ];
      monospace = [ "Noto Mono CJK JP" "Noto Mono" ];
    };
  };

  fonts.fontconfig.hinting.style = "hintfull";
  fonts.fontconfig.allowBitmaps = false;

  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = [ pkgs.fcitx5-mozc ];

  services.mullvad-vpn.enable = true;
  services.mullvad-vpn.enableExcludeWrapper = false;

  networking.networkmanager.wifi.macAddress = "random";
  networking.networkmanager.ethernet.macAddress = "random";
  services.resolved.llmnr = "false";

  environment.defaultPackages = [ ];
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Force containers to use mullvad
  networking.nat.enable = true;
  networking.nat.internalInterfaces = [ "ve-+" ];
  networking.nat.externalInterface = "wg-mullvad";

  services.interception-tools = {
    enable = true;
    plugins = [ pkgs.interception-tools-plugins.dual-function-keys ];
    udevmonConfig = ''
      - JOB: "${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.dual-function-keys}/bin/dual-function-keys -c /etc/dual-function-keys.yaml | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE"
        DEVICE:
          EVENTS:
            EV_KEY: [KEY_CAPSLOCK, KEY_ESC]
    '';
  };

  environment.etc."dual-function-keys.yaml".text = ''
    TIMING:
        - TAP_MILLISEC: 1000
        - DOUBLE_TAP_MILLISEC: 0
    MAPPINGS:
        - KEY: KEY_CAPSLOCK
          TAP: KEY_ESC
          HOLD: KEY_LEFTCTRL
        - KEY: KEY_SYSRQ
          TAP: KEY_SYSRQ
          HOLD: KEY_RIGHTMETA
  '';

  containers.test = let hostCfg = config;
  in {
    autoStart = false;
    privateNetwork = true;
    hostAddress = "192.168.100.10";
    localAddress = "192.168.100.11";

    bindMounts = {
      waylandDisplay = rec {
        hostPath = "/run/user/1000";
        mountPoint = hostPath;
      };
    };

    config = { config, pkgs, ... }: {
      programs.fish.enable = true;
      users.defaultUserShell = pkgs.fish;
      environment.shells = with pkgs; [ fish ];

      programs.npm.enable = true;

      nix.package = pkgs.nixFlakes;
      nix.settings.experimental-features = [ "nix-command" "flakes" ];
      programs.neovim.enable = true;
      environment.systemPackages = with pkgs; [
        p7zip
        kitty
        git
        unzip
        ripgrep
        gcc
        trashy
        mullvad-browser
        alacritty
        logseq
        feh
        wget
        exa
        fd
        fzf
        gdu
        ranger
        wofi
        lf
      ];

      environment.variables = { TERM = "xterm-kitty"; };

      environment.sessionVariables = {
        WAYLAND_DISPLAY = "wayland-1";
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        XDG_RUNTIME_DIR = "/run/user/1000";
        DISPLAY = ":1";
      };

      services.xserver.enable = true;

      hardware.opengl = {
        enable = true;
        extraPackages = hostCfg.hardware.opengl.extraPackages;
      };

      users.mutableUsers = false;
      users.allowNoPasswordLogin = true;

      users.users.user = {
        isNormalUser = true;
        home = "/home/user";
      };

      environment.defaultPackages = [ ];
      system.stateVersion = "22.11";
    };
  };

  system.stateVersion = "22.11";
}
