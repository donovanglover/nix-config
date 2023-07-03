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
      gb = "git branch"; # List all branches
      gbd = "git branch --delete";
      gc = "git commit -m";
      gca = "git commit --amend";
      gcl = "git clone";
      gco = "git checkout";
      gd = "git diff"; # Show all file changes not staged yet
      gds = "git diff --staged"; # Show changes staged but not committed
      gi = "git init";
      gl = "git log --oneline --decorate --all --graph -n 10";
      gm = "git merge";
      gp = "git push"; # Push your commits to a remote server
      gr = "git reset HEAD~"; # Undo the last commit but keep changed files
      gR = "git restore";
      gRs = "git restore --staged";
      gra = "git remote add";
      gre = "git remote --verbose"; # List all remotes
      grh = "git reset HEAD";
      grr = "git reset --hard HEAD~"; # Remove the last commit and all changes with it
      gs = "git status";
      gst = "git stash";
      gstp = "git stash pop";
      gt = "git tag";
      gts = "git tag -s";

      y = "yarn";
      ya = "yarn add";
      yar = "yarn remove";
      yi = "yarn init";
      yin = "yarn install";
      yu = "yarn upgrade-interactive";

      dl = "yt-dlp";
      vol = "wpctl set-volume '@DEFAULT_AUDIO_SINK@'"; # Change the volume, e.g. vol 10%+, vol 10%-, vol 100%
      nf = "clear; and neofetch --size 56%";
      df = "df --human-readable --type=ext4 --total";
      du = "du --human-readable --summarize";
      jis = "recode shift_jis..utf8"; # Easily convert shift_jis-encoded files to utf8
      utf16 = "recode utf16..utf8"; # Rarely, some files from Japan are utf16 instead
      jp = "LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8";
      vm = /* fish */ ''cd ~/nix-config && crystal spec tests/main.cr --progress --verbose --tag local && nixos-rebuild build-vm --flake . --verbose && ./result/bin/run-nixos-vm && trash put result nixos.qcow2'';
      sw = "cd ~/nix-config && crystal spec tests/main.cr --progress --verbose --tag local && sudo nixos-rebuild switch --flake . --verbose";
      st = "cd ~/nix-config && crystal spec tests/main.cr --progress --verbose --tag local";
      tf = "treefmt";

      c = "clear"; # Clear the terminal completely
      e = "exit";
      l = "ls -l";
      n = "nvim";
      j = "joshuto";
      t = "tree";
    };
  };
}
