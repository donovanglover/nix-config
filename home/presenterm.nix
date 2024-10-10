{ pkgs, ... }:

let
  inherit (builtins) toJSON;
in
{
  home.packages = with pkgs; [ presenterm ];

  xdg.configFile."presenterm/config.yaml".text = toJSON {
    defaults = {
      theme = "terminal-dark";
      validate_overflows = "always";
    };

    options.implicit_slide_ends = true;
  };
}
