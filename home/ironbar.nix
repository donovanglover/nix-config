{ config, ... }:

{
  xdg.configFile."ironbar/config.json".text = /* json */ ''
    {
      "name": "main",
      "icon_theme": "Fluent-dark",
      "position": "bottom",
      "anchor_to_edges": true,

      "start": [
        {
          "name": "startMenu",
          "type": "label",
          "label": "❄",
          "on_mouse_enter": "rofi -show drun"
        },
        {
          "type": "script",
          "on_click_left": "notify-send -t 2000 \"Mullvad\" \"Changing location...\" && mullvad relay set location any && mullvad relay set location us",
          "cmd": "mullvad status | choose 2..",
          "mode": "poll",
          "interval": 2500
        }
      ],

      "center": [
        {
          "type": "launcher",
          "icon_size": 39,
          "favorites": [
            "librewolf",
            "kitty",
            "thunar",
            "audacity",
            "Gimp-2.10",
            "org.qutebrowser.qutebrowser",
            "Logseq",
            "spek",
            "Mullvad Browser"
          ]
        }
      ],

      "end": [
        {
          "type": "tray"
        },
        {
          "type": "script",
          "cmd": "fish -c 'echo \"音量：$(math \"$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | choose 1) * 100\")%\"'",
          "mode": "poll",
          "interval": 2500
        },
        {
          "type": "clock",
          "format": "%x（%a）%R"
        }
      ]
    }
  '';

  xdg.configFile."ironbar/style.css".text = with config.lib.stylix.colors; /* css */ ''
    * {
      font-family: "Noto Sans CJK JP", "Font Awesome 6 Free Solid";
      font-size: 16px;
      text-shadow: 2px 2px #${base00};
      border: none;
      border-radius: 0;
      outline: none;
      font-weight: 500;
      background: none;
      color: #${base05};
    }

    .background {
      background: alpha(#${base00}, 0.925);
    }

    button:hover {
      background: #${base01};
    }

    #bar {
      border-top: 1px solid #${base01};
    }

    .label, .script, .tray {
      padding-left: 0.5em;
      padding-right: 0.5em;
    }

    .popup {
      border: 1px solid #${base01};
      padding: 1em;
    }

    .popup-clock .calendar-clock {
      font-family: "Maple Mono";
      font-size: 2.5em;
      padding-bottom: 0.1em;
    }

    .popup-clock .calendar .header {
      padding-top: 1em;
      border-top: 1px solid #${base01};
      font-size: 1.5em;
    }

    .popup-clock .calendar {
      padding: 0.2em 0.4em;
    }

    .popup-clock .calendar:selected {
      color: #${base09};
    }

    .launcher .item {
      padding-left: 1em;
      padding-right: 1em;
      margin-right: 4px;
    }

    button:active {
      background: #${base04};
    }

    .launcher .open {
      box-shadow: inset 0 -2px #${base04};
    }

    .launcher .focused {
      box-shadow: inset 0 -2px #${base09};
      background: #${base01};
    }

    .popup-launcher {
      padding: 0;
    }

    .popup-launcher .popup-item:not(:first-child) {
      border-top: 1px solid #${base01};
    }

    #startMenu {
      padding-left: 1em;
      padding-right: 0.5em;
    }
  '';
}
