{ config, lib, ... }:

let
  opacity = lib.strings.floatToString config.stylix.opacity.terminal;
  icons = true;
  position = "top";
  opposite = builtins.replaceStrings ["left" "right" "top" "bottom"] ["right" "left" "bottom" "top"] position;
  isVertical = position == "left" || position == "right";
  modules = {
    tray = {
      icon-size = 24;
      spacing = 8;
    };

    "wlr/taskbar" = {
      icon-size = 32;
      on-click = "activate";
      on-click-middle = "activate";
      on-click-right = "activate";
    };

    "hyprland/window" = {
      rotate = if isVertical then 90 else 0;
    };

    "wlr/workspaces" = {
      on-click = "activate";
      sort-by-number = true;
      format = "{icon}";
      format-icons = {
        "1" = "一";
        "2" = "二";
        "3" = "三";
        "4" = "四";
        "5" = "五";
        "6" = "六";
        "7" = "七";
        "8" = "八";
        "9" = "九";
        "10" = "十";
      };
    };

    wireplumber = {
      format = "{icon}";
      tooltip-format = "{volume}% {node_name}";
      format-muted = "";
      format-icons = [ "" "" ];
    };

    battery = {
      format = "{icon}";
      tooltip-format = "{capacity}% {timeTo}";
      format-icons = [ "" "" "" "" "" ];
    };

    clock = {
      format = if isVertical then "{:%H\n%M}" else "{:%H:%M}";
      tooltip-format = "<tt>{calendar}</tt>";
      calendar = {
        mode = "month";
        weeks-pos = "right";
        format = {
          months = "<span color='#ffead3'><b>{}</b></span>";
          days = "<span color='#ecc6d9'><b>{}</b></span>";
          weeks = "<span size='14pt' color='#99ffdd'><b>W{}</b></span>";
          weekdays = "<span size='18pt' color='#ffcc66'><b>{}</b></span>";
          today = "<span color='#ff6699'><b>{}</b></span>";
        };
      };
    };

    backlight = {
      format = "{icon}";
      format-icons = [ "" "" ];
    };

    "custom/new-workspace" = {
      format = "+";
      on-click = "hyprctl dispatch workspace empty && sleep 0.1 && rofi -show drun";
      on-click-right = "sleep 0.1 && rofi -show drun";
      on-click-middle = "hyprctl dispatch workspace empty";
      tooltip = false;
    };
  };
in
{
  programs.waybar = {
    enable = true;

    settings = {
      mainBar = modules // {
        layer = "top";
        position = position;
        width = if isVertical then 45 else null;
        height = if isVertical then null else 45;
        spacing = 8;

        autohide = true;
        exclusive = false;
        autohide-starthidden = true;

        modules-left = if icons then [ "wlr/taskbar" ] else [ "wlr/workspaces" "custom/new-workspace" ];
        modules-right = [ "wireplumber" "backlight" "battery" "clock" ];
      };
    };

    style = with config.lib.stylix.colors; lib.mkForce /* css */ ''
      * {
        color: #${base05};
        font-size: 16px;
      }

      window#waybar {
        background: alpha(#${base00}, ${opacity});
        border-${opposite}: 1px solid alpha(#${base02}, 0.67);
      }

      window#waybar.fullscreen #workspaces button.active {
        background: alpha(#${base09}, 0.5);
      }

      #workspaces button {
        padding: ${if isVertical then "12px 0" else "0 12px"};
        border-radius: 0;
        border-bottom: 1px solid alpha(#${base02}, 0.5);
      }

      #workspaces button:hover {
        background: inherit;
      }

      #workspaces button.active {
        background: alpha(#${base02}, 0.5);
      }

      #window {
        padding-${if isVertical then "top" else "left"}: 8px;
        padding-${if isVertical then "bottom" else "right"}: 12px;
      }

      tooltip, #tray menu {
        background: #${base00};
        border: 1px solid alpha(#${base09}, 0.93);
        padding: 8px;
      }

      #backlight, #battery, #wireplumber {
        font-family: "Font Awesome 6 Free Solid";
        font-size: 24px;
      }

      #custom-new-workspace {
        font-family: "Font Awesome 6 Free Solid";
        padding-${if isVertical then "top" else "left"}: 8px;
        padding-${if isVertical then "bottom" else "right"}: 8px;
        color: alpha(#${base0A}, 0.67);
      }

      #clock {
        font-size: 18px;
        font-weight: bold;
        padding-${if isVertical then "bottom" else "right"}: 8px;
      }
    '';
  };
}
