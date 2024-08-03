{ pkgs, ... }:

let
  inherit (pkgs) tig mgitstatus;
in
{
  home.packages = [
    tig
    mgitstatus
  ];

  xdg.configFile."tig/config".text = ''
    color cursor black green bold
    color title-focus black blue bold
    color title-blur black blue bold
  '';

  programs.git = {
    enable = true;

    aliases = {
      contrib = "shortlog -n -s";
      remotes = "remote -v";
      praise = "blame";
      verify = "log --show-signature";
    };

    attributes = [ "*.lockb binary diff=lockb" ];

    extraConfig = {
      include.path = "~/.gituser";
      commit.gpgsign = true;

      diff.lockb = {
        textconv = "bun";
        binary = true;
      };

      core = {
        editor = "nvim";
        autocrlf = false;
        quotePath = false;
      };

      push.default = "simple";
      pull.rebase = true;
      branch.autosetuprebase = "always";
      init.defaultBranch = "master";
      rerere.enabled = true;
      color.ui = true;

      blame = {
        date = "relative";
      };

      "color \"diff-highlight\"" = {
        oldNormal = "red bold";
        oldHighlight = "red bold";
        newNormal = "green bold";
        newHighlight = "green bold ul";
      };

      "color \"diff\"" = {
        meta = "yellow";
        frag = "magenta bold";
        commit = "yellow bold";
        old = "red bold";
        new = "green bold";
        whitespace = "red reverse";
      };
    };

    diff-so-fancy.enable = true;
  };
}
