{ config, lib, ... }:

let
  inherit (lib) mkForce;

  highlightTransparency = "0.3";
  getColorCh = colorName: channel: config.lib.stylix.colors."${colorName}-rgb-${channel}";
  rgba = color: ''rgba(${getColorCh color "r"}, ${getColorCh color "g"}, ${getColorCh color "b"}, ${highlightTransparency})'';
in
{
  programs.zathura = {
    enable = true;

    options = {
      guioptions = "v";
      adjust-open = "width";
      statusbar-basename = true;
      render-loading = false;
      scroll-step = 120;

      highlight-color = mkForce (rgba "base0A");
      highlight-active-color = mkForce (rgba "base0D");
    };
  };
}
