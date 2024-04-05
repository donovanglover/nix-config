{ pkgs, config, lib, ... }:

let
  inherit (pkgs) fish htop-vim;
  inherit (lib) mkEnableOption mkIf mkMerge singleton;
  inherit (builtins) attrValues;
  inherit (cfg) postgres;
  inherit (config.modules.system) username;

  cfg = config.modules.shell;
in
{
  options.modules.shell = {
    postgres = mkEnableOption "postgres database and pgcli for containers";
  };

  config = {
    users.defaultUserShell = fish;
    environment.shells = [ fish ];

    environment.sessionVariables = {
      GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
      FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
      NODE_OPTIONS = "--max_old_space_size=16384";
      BAT_THEME = "base16";
      GATSBY_TELEMETRY_DISABLED = "1";
      EDITOR = "nvim";
      VISUAL = "nvim";
    };

    environment.systemPackages = mkMerge [
      (attrValues {
        inherit (pkgs) wget jq eza fd fzf ripgrep;
      })

      (attrValues {
        inherit (pkgs) treefmt;
      })

      (attrValues {
        inherit (pkgs)
          neofetch
          onefetch
          scc
          genact
          dwt1-shell-color-scripts
          colorpanes
          sanctity
          cmatrix
        ;
      })
      (attrValues {
        inherit (pkgs)
          gdu
          hexyl
          visidata
          zellij
        ;
      })

      (attrValues {
        inherit (pkgs)
          p7zip
          unar
          rsync
          rclone
        ;
      })

      (mkIf postgres (attrValues {
        inherit (pkgs) pgcli;
      }))
    ];

    services.postgresql = mkIf postgres {
      enable = true;

      ensureUsers = singleton {
        name = username;
      };

      ensureDatabases = [ username ];
    };

    programs = {
      fish = {
        enable = true;

        shellAliases = {
          ls = "${pkgs.eza}/bin/eza --icons --group-directories-first --no-quotes -I 'lost+found'";
          tree = "${pkgs.eza}/bin/eza --icons --group-directories-first --no-quotes --all --long --tree -I 'node_modules|.git|public|lost+found|target|.next|.cache|.nuxt|themes|.direnv|.wrangler|.vercel|dist'";
          mv = "mv -i";
          cp = "cp -ia";
          rg = "${pkgs.ripgrep}/bin/rg --max-columns=2000 --smart-case";
          ncu = "${pkgs.npm-check-updates}/bin/ncu --interactive --format group";
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

          y = "yarn";
          ya = "yarn add";
          yb = "yarn build";
          yar = "yarn remove";
          yd = "yarn dev";
          yi = "yarn init";
          yin = "yarn install";
          yu = "yarn upgrade-interactive";

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
          nvd = "nvd --color always diff /run/current-system result | less -R";

          b = "bun";
          br = "bun run";
          bt = "bun test";
          bi = "bun init";
          bc = "bun create";
          bin = "bun install";
          ba = "bun add";
          brm = "bun remove";
          bu = "bun update";
          bb = "bun build";

          ci = "cargo init";
          cin = "cargo info";
          cu = "cargo update";
          ca = "cargo add";
          cab = "cargo add --build";
          cad = "cargo add --dev";
          cb = "cargo build";
          cr = "cargo run";
          cs = "cargo search";
          ct = "cargo test";
          cT = "cargo tree --depth 1";
          cn = "cargo new";
          crm = "cargo remove";
          crmb = "cargo remove --build";
          crmd = "cargo remove --dev";
          cc = "cargo clippy";
          cf = "cargo fmt";

          dc = "deno compile";
          dr = "deno run";
          di = "deno install";
          dt = "deno task";
          dT = "deno test --watch";

          p = "pnpm";
          pa = "pnpm add";
          pr = "pnpm remove";
          pd = "pnpm dev";
          pt = "pnpm test";
          pb = "pnpm build";
          pbs = "pnpm build && pnpm start";

          dl = "yt-dlp";
          vol = "wpctl set-volume '@DEFAULT_AUDIO_SINK@'"; # Change the volume, e.g. vol 10%+, vol 10%-, vol 100%
          df = "df --human-readable --total";
          du = "du --human-readable --summarize";
          jis = "recode shift_jis..utf8"; # Easily convert shift_jis-encoded files to utf8
          utf16 = "recode utf16..utf8"; # Rarely, some files from Japan are utf16 instead
          jp = "LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8";
          vm = "nixos-rebuild build-vm --flake . && ./result/bin/run-nixos-vm && trash put result nixos.qcow2";
          sw = "sudo nixos-rebuild switch --flake .";
          tf = "treefmt";
          mgs = "mgitstatus";

          c = "clear";
          e = "exit";
          k = "kitty @ set-background-opacity";
          l = "ls -l";
          n = "nvim";
          j = "yazi";
          t = "tree";
          z = "zathura";
        };
      };

      neovim.enable = true;
      direnv.enable = true;

      starship = {
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

          nix_shell = {
            format = "❄️ ";
            symbol = "nix ";
          };

          ocaml.symbol = "ml ";
          package.symbol = "pkg ";
          perl.symbol = "pl ";
          php.symbol = "php ";
          purescript.symbol = "purs ";
          python.symbol = "python ";
          ruby.symbol = "ruby ";

          rust = {
            symbol = "rust ";
            disabled = true;
          };

          bun = {
            symbol = "bun ";
            disabled = true;
          };

          scala.symbol = "scala ";
          swift.symbol = "swift ";
        };
      };

      htop = {
        enable = true;
        package = htop-vim;

        settings = {
          tree_view = true;
          hide_userland_threads = true;
          highlight_changes = true;
          show_cpu_frequency = true;
          show_cpu_temperature = true;
          highlight_base_name = true;

          show_program_path = false;
        };
      };
    };
  };
}
