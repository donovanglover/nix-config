{
  programs.fish = {
    enable = true;

    loginShellInit = # fish
      ''
        if test (tty) = /dev/tty2
          exec startx
        end
      '';

    shellInit = # fish
      ''
        set -U fish_greeting ""

        set -x -U LESS_TERMCAP_md (printf "\e[01;31m")
        set -x -U LESS_TERMCAP_me (printf "\e[0m")
        set -x -U LESS_TERMCAP_se (printf "\e[0m")
        set -x -U LESS_TERMCAP_so (printf "\e[01;44;30m")
        set -x -U LESS_TERMCAP_ue (printf "\e[0m")
        set -x -U LESS_TERMCAP_us (printf "\e[01;32m")
        set -x -U MANROFFOPT "-c"

        fish_default_key_bindings

        if string match -qe -- "/dev/pts/" (tty)
          alias ssh="kitty +kitten ssh"
        end
      '';

    shellAliases = {
      tree = "eza --all --long --tree";
      mv = "mv -i";
      cp = "cp -ia";
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
      gpu = "git pull";
      gr = "git reset HEAD~";
      gR = "git restore";
      gRs = "git restore --staged";
      gra = "git remote add";
      gre = "git remote --verbose";
      grh = "git reset HEAD";
      grr = "git reset --hard HEAD~";
      grb = "git rebase --interactive";
      grbc = "git rebase --continue";
      gs = "git status";
      gsma = "git submodule add";
      gsmu = "git submodule update --init --remote --recursive";
      gst = "git stash";
      gstp = "git stash pop";
      gsw = "git switch";
      gt = "git tag";
      gts = "git tag -s";

      tp = "trash put";
      tl = "trash list";
      tr = "trash restore";
      te = "trash empty";

      nf = "nix flake";
      nfc = "nix flake check";
      nfu = "nix flake update";
      npr = "nixpkgs-review pr --run fish --print-result";
      nd = "nix develop --command fish";
      nb = "nix build";
      ns = "nix shell";
      nr = "nix run";
      ncg = "sudo nix-collect-garbage -d && nix-collect-garbage -d";
      nvd = "nvd --color always diff /run/current-system result | rg -v 0.0.0 | less -R";

      ca = "cargo add";
      cab = "cargo add --build";
      cad = "cargo add --dev";
      cb = "cargo build";
      cr = "cargo run";
      ct = "cargo test";
      crm = "cargo remove";
      crmb = "cargo remove --build";
      crmd = "cargo remove --dev";
      cc = "cargo clippy";
      cf = "cargo fmt";

      dl = "yt-dlp";
      vol = "wpctl set-volume '@DEFAULT_AUDIO_SINK@'";
      jis = "recode shift_jis..utf8";
      utf16 = "recode utf16..utf8";
      jp = "LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8";
      vm = "nixos-rebuild build-vm --flake . && ./result/bin/run-nixos-vm && trash put result nixos.qcow2";
      sw = "sudo nixos-rebuild switch --flake .";
      mgs = "mgitstatus";
      ncu = "ncu --interactive --format group";

      c = "clear";
      e = "exit";
      k = "kitty @ set-background-opacity";
      l = "ls -l";
      n = "nvim";
      j = "yazi";
      t = "tree";
      z = "zathura";
    };

    functions = {
      wav2flac = # fish
        ''
          set ORIGINAL_SIZE (du -hs | cut -f1)

          fd -e wav -x ffmpeg -i "file:{}" -loglevel quiet -stats "file:{.}.flac"
          fd -e wav -X trash

          set NEW_SIZE (du -hs | cut -f1)

          echo "Done. Reduced file size from $ORIGINAL_SIZE to $NEW_SIZE"
        '';

      opus = # fish
        ''
          set ORIGINAL_SIZE (du -hs | cut -f1)

          fd -e wav -e flac -x ffmpeg -i "file:{}" -c:a libopus -b:a 128K -loglevel quiet -stats "file:{.}.opus"
          fd -e wav -e flac -X rm -I

          set NEW_SIZE (du -hs | cut -f1)

          echo "Done. Reduced file size from $ORIGINAL_SIZE to $NEW_SIZE"
        '';

      pr = # fish
        ''
          if git remote | rg -q upstream
            git fetch upstream "pull/$argv/head" && git checkout FETCH_HEAD
          else
            git fetch origin "pull/$argv/head" && git checkout FETCH_HEAD
          end
        '';

      ex = # fish
        ''
          if string match -qe -- ".part1." "$argv";
            set BASE (string split -f 1 ".part1." "$argv")

            unar "$argv" && fd -d 1 "$BASE.part" -X trash
          else if string match -qe -- ".part01." "$argv";
            set BASE (string split -f 1 ".part01." "$argv")

            unar "$argv" && fd -d 1 "$BASE.part" -X trash
          else
            unar "$argv" && trash "$argv"
          end
        '';

      mullvad-init = # fish
        ''
          mullvad auto-connect set on
          mullvad lan set allow
          mullvad relay set location us
          mullvad lockdown-mode set on
          mullvad account login "$argv"
        '';
    };
  };
}
