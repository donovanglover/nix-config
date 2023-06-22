{ config, lib, ... }:

{
  programs.rofi = {
    enable = true;
    cycle = false;

    extraConfig = {
      modi = "drun,filebrowser";
      font = "Noto Sans CJK JP 12";
      show-icons = true;
      bw = 0;
      display-drun = "";
      display-window = "";
      display-combi = "";
      icon-theme = "Fluent-dark";
      terminal = "kitty";
      drun-match-fields = "name";
      drun-display-format = "{name}";
      me-select-entry = "";
      me-accept-entry = "MousePrimary";
    };

    theme = let inherit (config.lib.formats.rasi) mkLiteral; in lib.mkForce {
      "*" = {
        font = "Noto Sans CJK JP Bold 12";

        bg0 = mkLiteral "#242424dd";
        bg1 = mkLiteral "#363636";
        bg2 = mkLiteral "#f5f5f520";
        bg3 = mkLiteral "#f5f5f540";
        bg4 = mkLiteral "#0860f2E6";

        fg0 = mkLiteral "#f5f5f5";
        fg1 = mkLiteral "#f5f5f580";

        background-color = mkLiteral "transparent";
        foreground = mkLiteral "#f8f8f2";
        text-color = mkLiteral "@fg0";
        padding = mkLiteral "0px";
        margin = mkLiteral "0px";
      };

      window = {
        fullscreen = true;
        padding = mkLiteral "1em";
        background-color = mkLiteral "@bg0";
      };

      mainbox = {
        padding = mkLiteral "8px";
      };

      inputbar = {
        background-color = mkLiteral "@bg2";

        margin = mkLiteral "0px calc( 50% - 230px )";
        padding = mkLiteral "4px 8px";
        spacing = mkLiteral "8px";

        border = mkLiteral "1px";
        border-radius = mkLiteral "2px";
        border-color = mkLiteral "@bg3";

        children = map mkLiteral [ "icon-search" "entry" ];
      };

      prompt = {
        enabled = false;
      };

      icon-search = {
        expand = false;
        filename = "search";
        vertical-align = mkLiteral "0.5";
      };

      entry = {
        placeholder = "Search";
        placeholder-color = mkLiteral "@bg2";
      };

      listview = {
        margin = mkLiteral "48px calc( 50% - 560px )";
        spacing = mkLiteral "48px";
        columns = 5;
        fixed-columns = true;
      };

      "element, element-text, element-icon" = {
        cursor = mkLiteral "pointer";
      };

      element = {
        padding = mkLiteral "8px";
        spacing = mkLiteral "4px";

        orientation = mkLiteral "vertical";
        border-radius = mkLiteral "16px";
      };

      "element selected" = {
        background-color = mkLiteral "rgba(248, 248, 242, 0.3)";
      };

      element-icon = {
        size = mkLiteral "5em";
        horizontal-align = mkLiteral "0.5";
      };

      element-text = {
        horizontal-align = mkLiteral "0.5";
      };
    };
  };
}
