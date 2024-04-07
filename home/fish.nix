{ pkgs, ... }:

let
  inherit (pkgs) gsettings-desktop-schemas prisma-engines gtk3;
in
{
  programs.fish = {
    enable = true;

    shellInit = /* fish */ ''
      set -U fish_greeting ""

      export PATH="$HOME/.deno/bin:$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.local/bin:$HOME/.go/bin:$PATH"
      export GOPATH="$HOME/.go"
      export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
      export TERMCMD="kitty --single-instance"
      export XDG_DATA_DIRS="${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS"
      export DIRENV_LOG_FORMAT=""
      export PRISMA_SCHEMA_ENGINE_BINARY="${prisma-engines}/bin/schema-engine"
      export PRISMA_QUERY_ENGINE_BINARY="${prisma-engines}/bin/query-engine"
      export PRISMA_QUERY_ENGINE_LIBRARY="${prisma-engines}/lib/libquery_engine.node"
      export PRISMA_INTROSPECTION_ENGINE_BINARY="${prisma-engines}/bin/introspection-engine"
      export PRISMA_FMT_BINARY="${prisma-engines}/bin/prisma-fmt"

      # Required to make gpg-agent work in cases like git commit
      export GPG_TTY=(tty)

      # Add color to man pages
      set -x -U LESS_TERMCAP_md (printf "\e[01;31m")
      set -x -U LESS_TERMCAP_me (printf "\e[0m")
      set -x -U LESS_TERMCAP_se (printf "\e[0m")
      set -x -U LESS_TERMCAP_so (printf "\e[01;44;30m")
      set -x -U LESS_TERMCAP_ue (printf "\e[0m")
      set -x -U LESS_TERMCAP_us (printf "\e[01;32m")
      set -x -U MANROFFOPT "-c"

      # Always use the default keybindings in fish
      fish_default_key_bindings

      # Always use kitty ssh since it's our default terminal
      if string match -qe -- "/dev/pts/" (tty)
        alias ssh="kitty +kitten ssh"
      end
    '';

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

    functions = {
      wav2flac = /* fish */ ''
        set ORIGINAL_SIZE (du -hs | cut -f1)

        fd -e wav -x ffmpeg -i "{}" -loglevel quiet -stats "{.}.flac"
        fd -e wav -X trash

        set NEW_SIZE (du -hs | cut -f1)

        echo "Done. Reduced file size from $ORIGINAL_SIZE to $NEW_SIZE"
      '';

      opus = /* fish */ ''
        set ORIGINAL_SIZE (du -hs | cut -f1)

        fd -e wav -e flac -x ffmpeg -i "{}" -c:a libopus -b:a 128K -loglevel quiet -stats "{.}.opus"
        fd -e wav -e flac -X rm -I

        set NEW_SIZE (du -hs | cut -f1)

        echo "Done. Reduced file size from $ORIGINAL_SIZE to $NEW_SIZE"
      '';
    };
  };
}
