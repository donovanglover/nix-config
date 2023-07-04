{
  xdg.configFile."ironbar/config.json".text = /* json */ ''
    {
      "icon_theme": "Fluent-dark",
      "position": "bottom",
      "anchor_to_edges": true,

      "start": [
        {
          "all_monitors": false,
          "name_map": {
            "1": "一",
            "2": "二",
            "3": "三",
            "4": "四",
            "5": "五",
            "6": "六",
            "7": "七",
            "8": "八",
            "9": "九",
            "10": "十"
          },
          "type": "workspaces"
        }
      ],

      "center": [
        {
          "show_icons": true,
          "type": "launcher",
          "favorites": [
            "librewolf",
            "kitty",
            "link-test",
            "thunar",
            "osu!",
            "qutebrowser"
          ]
        }
      ],

      "end": [
        {
          "type": "sys_info",
          "format": [
            " {cpu_percent}%",
            " {memory_used} GB ({memory_percent}%)",
            " {disk_used:/} GB ({disk_percent:/}%)"
          ],
          "interval": {
            "cpu": 1,
            "disks": 300,
            "memory": 30
          }
        },

        {
          "type": "label",
          "label": "   "
        },

        {
          "type": "label",
          "label": "{{cat /sys/class/power_supply/BAT0/capacity}}%"
        },

        {
          "type": "clipboard",
          "max_items": 3,
          "truncate": {
            "length": 50,
            "mode": "end"
          }
        },

        {
          "type": "clock",
          "format": "%x（%a）%R"
        }
      ]
    }
  '';

  xdg.configFile."ironbar/style.css".text = /* css */ ''
    @define-color color_bg #272822;
    @define-color color_bg_dark #383838;
    @define-color color_border #383838;
    @define-color color_border_active #fd971f;
    @define-color color_text #ffffff;
    @define-color color_urgent #8f0a0a;

    * {
      font-family: "Noto Sans CJK JP", "Font Awesome 6 Free Solid";
      font-size: 16px;
      border: none;
      border-radius: 0;
      outline: none;
      font-weight: 500;
      background: none;
    }

    .background {
      background: alpha(@color_bg, 0.95);
    }

    button, label {
      color: @color_text;
    }

    button:hover {
      background: @color_bg_dark;
    }

    #bar {
      border-top: 1px solid @color_border;
    }

    .popup {
      border: 1px solid @color_border;
      padding: 1em;
    }

    .clipboard {
      margin-left: 5px;
      font-size: 1.1em;
    }

    .popup-clipboard .item {
      padding-bottom: 0.3em;
    }

    .clock {
      font-weight: 400;
      margin-left: 0;
    }

    .popup-clock .calendar-clock {
      color: @color_text;
      font-family: "Maple Mono";
      font-size: 2.5em;
      padding-bottom: 0.1em;
    }

    .popup-clock .calendar {
      background: @color_bg;
      color: @color_text;
    }

    .popup-clock .calendar .header {
      padding-top: 1em;
      border-top: 1px solid @color_border;
      font-size: 1.5em;
    }

    .popup-clock .calendar:selected {
      background: @color_border_active;
    }

    .launcher .item {
      margin-right: 4px;
    }

    .launcher .item:not(.focused):hover {
      background: @color_bg_dark;
    }

    .launcher .open {
      border-bottom: 1px solid @color_text;
    }

    .launcher .focused {
      border-bottom: 1px solid @color_border_active;
    }

    .launcher .urgent {
      border-bottom: @color_urgent;
    }

    .popup-launcher {
      padding: 0;
    }

    .popup-launcher .popup-item:not(:first-child) {
      border-top: 1px solid @color_border;
    }

    .script {
      padding-left: 10px;
    }

    .sysinfo {
      margin-left: 10px;
    }

    .sysinfo .item {
      margin-left: 5px;
    }

    .tray {
      margin-left: 10px;
    }

    .workspaces .item.focused {
      box-shadow: inset 0 -3px;
    }

    .workspaces .item:hover {
      box-shadow: inset 0 -3px;
    }
  '';
}
