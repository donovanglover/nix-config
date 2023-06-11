{ pkgs, ... }:

let VARIABLES = import ../../src/variables.nix; in {
  environment.systemPackages = with pkgs; [ tig git ];

  home-manager.sharedModules = [
    {
      xdg.configFile."tig/config".text = ''
        color cursor black green bold
        color title-focus black blue bold
        color title-blur black blue bold
      '';

      programs.git = {
        enable = true;

        extraConfig = {
          include.path = "~/.gituser";
          commit.gpgsign = true;

          core = {
            editor = "nvim";
            autocrlf = false;
            quotePath = false;
          };

          web.browser = VARIABLES.defaultBrowser;
          push.default = "simple";
          branch.autosetuprebase = "always";
          init.defaultBranch = "master";
          rerere.enabled = true;
          color.ui = true;

          alias = {
            contrib = "shortlog -n -s";
            remotes = "remote -v";
            praise = "blame";
            verify = "log --show-signature";
          };

          "color \"diff-highlight\"" = {
            oldNormal = "red bold";
            oldHighlight = "red bold";
            newNormal = "green bold";
            newHighlight = "green bold";
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
  ];
}
