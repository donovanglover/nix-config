{ pkgs, ... }:

{
  users.defaultUserShell = pkgs.fish;
  environment.shells = [ pkgs.fish ];

  environment.sessionVariables = {
    GIT_DISCOVERY_ACROSS_FILESYSTEM = "1";
    FZF_DEFAULT_OPTS = "--height 40% --reverse --border --color=16";
    NODE_OPTIONS = "--max_old_space_size=16384";
    BAT_THEME = "base16";
    GATSBY_TELEMETRY_DISABLED = "1";
  };

  environment.systemPackages = with pkgs; [
    wget
    jq
    eza
    fd
    fzf
    ripgrep
  ];

  programs.fish = {
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
      nfu = "nix flake update";
      npr = "nixpkgs-review pr --run fish --print-result";
      nd = "nix develop --command fish";
      nb = "nix build";
      ns = "nix shell";
      nr = "nix run";
      ncg = "sudo nix-collect-garbage -d";
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
}
