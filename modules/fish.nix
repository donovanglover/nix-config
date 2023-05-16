{
  programs.fish = {
    shellAbbrs = {
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
  };
}
