{pkgs, ...}: let
  VARIABLES = import ../../src/variables.nix;
in {
  users.defaultUserShell = pkgs.fish;
  environment.shells = [pkgs.fish];

  programs.fish = {
    enable = true;

    shellAliases = {
      ls = "exa --group-directories-first -I 'lost+found'";
      tree = "exa --group-directories-first --all --long --tree -I 'node_modules|.git|public|lost+found'";
      mv = "mv -i";
      cp = "cp -ia";
      rg = "rg --max-columns=2000 --smart-case";
      yarn = "yarn --emoji true";
    };

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
      nf = "tput clear; and neofetch --size 56%";
      df = "df --human-readable --type=ext4 --total";
      du = "du --human-readable --summarize";
      jis = "recode shift_jis..utf8"; # Easily convert shift_jis-encoded files to utf8
      utf16 = "recode utf16..utf8"; # Rarely, some files from Japan are utf16 instead
      jp = "LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8";
      vm = "cd ~/nix-config && crystal spec tests/main.cr --progress --verbose && nixos-rebuild build-vm --flake . --verbose && ./result/bin/run-${VARIABLES.hostname}-vm && trash put result ${VARIABLES.hostname}.qcow2";
      sw = "cd ~/nix-config && crystal spec tests/main.cr --progress --verbose && sudo nixos-rebuild switch --flake . --verbose";
      st = "cd ~/nix-config && crystal spec tests/main.cr --progress --verbose";

      c = "tput clear"; # Clear the terminal completely
      e = "exit";
      k = "kitty @ set-colors -c -a ~/.cache/wal/kitty";
      l = "ls -l";
      n = "nvim";
      j = "joshuto";
      w = "wal -o ~/.config/wal/done.sh";
      t = "tree";
    };
  };

  home-manager.sharedModules = [
    {
      xdg.configFile."fish/config.fish".text = ''
        set -U fish_greeting ""

        export PATH="$HOME/.deno/bin:$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.local/bin:$HOME/.go/bin:$PATH"
        export GOPATH="$HOME/.go"
        export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
        export TERMCMD="kitty --single-instance"

        # Required to make gpg-agent work in cases like git commit
        export GPG_TTY=(tty)

        # Add color to man pages
        set -x -U LESS_TERMCAP_md (printf "\e[01;31m")
        set -x -U LESS_TERMCAP_me (printf "\e[0m")
        set -x -U LESS_TERMCAP_se (printf "\e[0m")
        set -x -U LESS_TERMCAP_so (printf "\e[01;44;30m")
        set -x -U LESS_TERMCAP_ue (printf "\e[0m")
        set -x -U LESS_TERMCAP_us (printf "\e[01;32m")

        # Always use the default keybindings in fish
        fish_default_key_bindings

        # Convert unnecessarily large wav files to flac
        function wav2flac
            set ORIGINAL_SIZE (du -hs | cut -f1)

            fd -e wav -x ffmpeg -i "{}" -loglevel quiet -stats "{.}.flac"
            fd -e wav -X trash

            set NEW_SIZE (du -hs | cut -f1)

            echo "Done. Reduced file size from $ORIGINAL_SIZE to $NEW_SIZE"
        end

        # Convert wav/flac to opus
        function opus
            set ORIGINAL_SIZE (du -hs | cut -f1)

            fd -e wav -e flac -x ffmpeg -i "{}" -c:a libopus -b:a 128K -loglevel quiet -stats "{.}.opus"
            fd -e wav -e flac -X rm -I

            set NEW_SIZE (du -hs | cut -f1)

            echo "Done. Reduced file size from $ORIGINAL_SIZE to $NEW_SIZE"
        end

        # Always use kitty ssh since it's our default terminal
        if string match -qe -- "/dev/pts/" (tty)
            alias ssh="kitty +kitten ssh"
        end

        if status is-login
            if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
                exec Hyprland
            end
        end
      '';
    }
  ];

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

      line_break.disabled = true;

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
}
