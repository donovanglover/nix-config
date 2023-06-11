{ lib
, hyprland
, ...
}: {
  home-manager.sharedModules = [
    {
      programs.waybar = {
        enable = true;
        package = hyprland.packages."x86_64-linux".waybar-hyprland;

        settings = {
          mainBar = {
            layer = "top";
            position = "right";
            width = 45;
            spacing = 8;

            modules-left = [ "wlr/workspaces" "custom/new-workspace" ];
            modules-right = [ "tray" "wireplumber" "backlight" "battery" "clock" ];

            tray = {
              icon-size = 24;
              spacing = 8;
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
              "format" = "{icon}";
              "tooltip-format" = "{capacity}% {timeTo}";
              "format-icons" = [ "" "" "" "" "" ];
            };

            clock = {
              "format" = "{:%H\n%M}";
              "tooltip-format" = "<tt>{calendar}</tt>";
              "calendar" = {
                "mode" = "month";
                "weeks-pos" = "right";
                "format" = {
                  "months" = "<span color='#ffead3'><b>{}</b></span>";
                  "days" = "<span color='#ecc6d9'><b>{}</b></span>";
                  "weeks" = "<span size='14pt' color='#99ffdd'><b>W{}</b></span>";
                  "weekdays" = "<span size='18pt' color='#ffcc66'><b>{}</b></span>";
                  "today" = "<span color='#ff6699'><b>{}</b></span>";
                };
              };
            };

            backlight = {
              "format" = "{icon}";
              "format-icons" = [ "" "" ];
            };

            "custom/new-workspace" = {
              "format" = "+";
              "on-click" = "hyprctl dispatch workspace empty && sleep 0.1 && rofi -show drun";
              "on-click-right" = "sleep 0.1 && rofi -show drun";
              "on-click-middle" = "hyprctl dispatch workspace empty";
              "tooltip" = false;
            };
          };
        };

        style = lib.mkForce ''
          @define-color base00 #272822;
          @define-color base01 #383830;
          @define-color base02 #49483e;
          @define-color base03 #75715e;
          @define-color base04 #a59f85;
          @define-color base05 #f8f8f2;
          @define-color base06 #f5f4f1;
          @define-color base07 #f9f8f5;
          @define-color base08 #f92672;
          @define-color base09 #fd971f;
          @define-color base0A #f4bf75;
          @define-color base0B #a6e22e;
          @define-color base0C #a1efe4;
          @define-color base0D #66d9ef;
          @define-color base0E #ae81ff;
          @define-color base0F #cc6633;

          * {
            color: @base05;
            font-size: 16px;
          }

          window#waybar {
            background: alpha(@base00, 0.92);
            border-left: 1px solid alpha(@base02, 0.67);
          }

          #workspaces button {
            padding: 12px 0;
            border-radius: 0;
            border-bottom: 1px solid alpha(@base02, 0.5);
          }

          #workspaces button.active {
            background: alpha(@base02, 0.5);
          }

          #window {
            padding-top: 8px;
            padding-bottom: 12px;
          }

          tooltip, #tray menu {
            background: @base00;
            border: 1px solid alpha(@base09, 0.93);
            padding: 8px;
          }

          #backlight, #battery, #wireplumber {
            font-family: "Font Awesome 6 Free Solid";
            font-size: 24px;
          }

          #custom-new-workspace {
            font-family: "Font Awesome 6 Free Solid";
            padding-top: 8px;
            padding-bottom: 8px;
            color: alpha(@base0A, 0.67);
          }

          #clock {
            font-size: 18px;
            font-weight: bold;
            padding-bottom: 8px;
          }
        '';
      };
    }
  ];
}
