{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.fish;
  environment.shells = [ pkgs.fish ];

  environment.sessionVariables = {
    GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
    FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
    NODE_OPTIONS = "--max_old_space_size=16384";
    BAT_THEME = "base16";
  };

  environment.systemPackages = with pkgs; [
    wget
    jq
    exa
    fd
    fzf
    ripgrep
  ];

  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "${pkgs.exa}/bin/exa --group-directories-first -I 'lost+found'";
      tree = "${pkgs.exa}/bin/exa --group-directories-first --all --long --tree -I 'node_modules|.git|public|lost+found|target'";
      mv = "mv -i";
      cp = "cp -ia";
      rg = "${pkgs.ripgrep}/bin/rg --max-columns=2000 --smart-case";
      yarn = "${pkgs.yarn}/bin/yarn --emoji true";
    };

    shellAbbrs = {
      g = "git";
      ga = "git add";
      gaa = "git add --all";
      gap = "git add --patch";
      gapp = "git apply";
      gb = "git branch --verbose";
      gbr = "git branch --verbose --remotes";
      gbd = "git branch --delete";
      gbD = "git branch --delete --force";
      gc = "git commit -m";
      gca = "git commit --amend";
      gcl = "git clone";
      gco = "git checkout";
      gcot = "git checkout --theirs";
      gcp = "git cherry-pick --strategy-option theirs";
      gcpx = "git cherry-pick --strategy-option theirs -x";
      gd = "git diff";
      gds = "git diff --staged";
      gf = "git fetch";
      gi = "git init";
      gl = "git log --oneline --decorate --graph -n 10";
      gm = "git merge";
      gp = "git push";
      gr = "git reset HEAD~";
      gR = "git restore";
      gRs = "git restore --staged";
      gra = "git remote add";
      gre = "git remote --verbose";
      grh = "git reset HEAD";
      grr = "git reset --hard HEAD~";
      gs = "git status";
      gst = "git stash";
      gstp = "git stash pop";
      gsw = "git switch";
      gt = "git tag";
      gts = "git tag -s";

      y = "yarn";
      ya = "yarn add";
      yar = "yarn remove";
      yi = "yarn init";
      yin = "yarn install";
      yu = "yarn upgrade-interactive";

      tp = "trash put";
      tl = "trash list";
      tr = "trash restore";
      te = "trash empty";

      nf = "nix flake";
      nfu = "nix flake update";
      nd = "nix develop --command fish";
      nb = "nix build";
      ns = "nix shell";
      nr = "nix run";
      ncg = "sudo nix-collect-garbage d";

      ci = "cargo init";
      cin = "cargo info";
      cu = "cargo update";
      ca = "cargo add";
      cb = "cargo build";
      cr = "cargo run";
      cs = "cargo search";
      cn = "cargo new";
      crm = "cargo remove";
      cc = "cargo clippy";
      cf = "cargo fmt";

      dl = "yt-dlp";
      vol = "wpctl set-volume '@DEFAULT_AUDIO_SINK@'"; # Change the volume, e.g. vol 10%+, vol 10%-, vol 100%
      df = "df --human-readable --type=ext4 --total";
      du = "du --human-readable --summarize";
      jis = "recode shift_jis..utf8"; # Easily convert shift_jis-encoded files to utf8
      utf16 = "recode utf16..utf8"; # Rarely, some files from Japan are utf16 instead
      jp = "LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8";
      vm = /* fish */ ''cd ~/nix-config && crystal spec tests/main.cr --progress --verbose --tag local && nixos-rebuild build-vm --flake . --verbose && ./result/bin/run-nixos-vm && trash put result nixos.qcow2'';
      sw = "cd ~/nix-config && crystal spec tests/main.cr --progress --verbose --tag local && sudo nixos-rebuild switch --flake . --verbose";
      st = "cd ~/nix-config && crystal spec tests/main.cr --progress --verbose --tag local";
      tf = "treefmt";

      c = "clear";
      e = "exit";
      k = "kitty @ set-background-opacity";
      l = "ls -l";
      n = "nvim";
      j = "joshuto";
      t = "tree";
    };
  };
}
