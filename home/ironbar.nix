{
  nix-config,
  config,
  lib,
  pkgs,
  ...
}:

let
  inherit (lib) singleton;
  inherit (builtins) toJSON;
  inherit (nix-config.packages.${pkgs.system}) dunst-scripts;

  inherit (config.lib.stylix.colors.withHashtag)
    base00
    base01
    base04
    base05
    base0D
    ;

  mullvadScript = "ironbar/mullvad.fish";
  volumeScript = "ironbar/volume.fish";
  volumeGet = "ironbar/volume-get.fish";
in
{
  home.packages = with pkgs; [ ironbar ];

  xdg.configFile = {
    "ironbar/config.json".text = toJSON {
      name = "main";
      icon_theme = "Fluent-dark";
      position = "bottom";
      anchor_to_edges = true;

      start = [
        {
          name = "startMenu";
          type = "label";
          label = "❄";
          on_mouse_enter = "rofi -show drun";
        }
        {
          type = "script";
          on_click_left = "mullvad relay set location any && mullvad relay set location us";
          cmd = "~/.config/${mullvadScript}";
          mode = "watch";
        }
      ];

      center = singleton {
        type = "launcher";
        icon_size = 39;
        favorites = [
          "librewolf"
          "kitty"
          "thunar"
          "org.qutebrowser.qutebrowser"
          "anki"
        ];
      };

      end = [
        {
          type = "script";
          cmd = "~/.config/${volumeScript}";
          on_click_left = "${dunst-scripts}/bin/mv-up";
          on_click_right = "${dunst-scripts}/bin/mv-down";
          mode = "watch";
        }
        {
          type = "upower";
          show_if = "upower -e | grep BAT";
        }
        {
          type = "clock";
          format = "%x（%a）%R";
        }
      ];
    };

    "ironbar/style.css".text = # css
      ''
        * {
          font-family: "Noto Sans CJK JP", "Font Awesome 6 Free Solid";
          font-size: 16px;
          text-shadow: 2px 2px ${base00};
          border: none;
          border-radius: 0;
          outline: none;
          font-weight: 500;
          background: none;
          color: ${base05};
        }

        .background {
          background: alpha(${base00}, 0.925);
        }

        button:hover {
          background: ${base01};
        }

        #bar {
          border-top: 1px solid ${base01};
        }

        .label, .script, .tray {
          padding-left: 0.5em;
          padding-right: 0.5em;
        }

        .upower {
          padding-left: 0.2em;
          padding-right: 0.2em;
        }

        .upower .label {
          padding-left: 0;
          padding-right: 0;
        }

        .popup {
          border: 1px solid ${base01};
          padding: 1em;
        }

        .popup-clock .calendar-clock {
          font-family: "Maple Mono";
          font-size: 2.5em;
          padding-bottom: 0.1em;
        }

        .popup-clock .calendar .header {
          padding-top: 1em;
          border-top: 1px solid ${base01};
          font-size: 1.5em;
        }

        .popup-clock .calendar {
          padding: 0.2em 0.4em;
        }

        .popup-clock .calendar:selected {
          color: ${base0D};
        }

        .launcher .item {
          padding-left: 1em;
          padding-right: 1em;
          margin-right: 4px;
        }

        button:active {
          background: ${base04};
        }

        .launcher .open {
          box-shadow: inset 0 -2px ${base04};
        }

        .launcher .focused {
          box-shadow: inset 0 -2px ${base0D};
          background: ${base01};
        }

        .popup-launcher {
          padding: 0;
        }

        .popup-launcher .popup-item:not(:first-child) {
          border-top: 1px solid ${base01};
        }

        #startMenu {
          padding-left: 1em;
          padding-right: 0.5em;
        }
      '';

    ${mullvadScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          sleep 2

          function get_mullvad_status
            if test -z "$inside"
              set inside true
              test -n "$initialized" && sleep 0.2

              set MULLVAD (mullvad status | head -1)

              set LOCATION (echo "$MULLVAD" | choose 4.. | sed \
                -e 's/Ashburn.*/アッシュバーン/g' \
                -e 's/Atlanta.*/アトランタ/g' \
                -e 's/Boston.*/ボストン/g' \
                -e 's/Charlotte.*/シャーロット/g' \
                -e 's/Chicago.*/シカゴ/g' \
                -e 's/Cleveland.*/クリーブランド/g' \
                -e 's/Dallas.*/ダラス/g' \
                -e 's/Detroit.*/デトロイト/g' \
                -e 's/Denver.*/デンバー/g' \
                -e 's/Honolulu.*/ホノルル/g' \
                -e 's/Houston.*/ヒューストン/g' \
                -e 's/Jackson.*/ジャクソン/g' \
                -e 's/Los Angeles.*/ロサンゼルス/g' \
                -e 's/Louisville.*/ルイビル/g' \
                -e 's/McAllen.*/マッカレン/g' \
                -e 's/Miami.*/マイアミ/g' \
                -e 's/Milwaukee.*/ミルウォーキー/g' \
                -e 's/Minneapolis.*/ミネアポリス/g' \
                -e 's/New York.*/ニューヨーク/g' \
                -e 's/Oklahoma.*/オクラホマシティ/g' \
                -e 's/Philadelphia.*/フィラデルフィア/g' \
                -e 's/Phoenix.*/フィニックス/g' \
                -e 's/Piscataway.*/ピスカタウェイ/g' \
                -e 's/Portland.*/ポートランド/g' \
                -e 's/Raleigh.*/ローリー/g' \
                -e 's/Richmond.*/リッチモンド/g' \
                -e 's/Salt Lake.*/ソルトレイクシティ/g' \
                -e 's/San Francisco.*/サンフランシスコ/g' \
                -e 's/San Jose.*/サンノゼ/g' \
                -e 's/Seattle.*/シアトル/g' \
                -e 's/Secaucus.*/セコーカス/g' \
                -e 's/Sioux Falls.*/スーフォールズ/g' \
                -e 's/St. Louis.*/セントルイス/g' \
                -e 's/Stamford.*/スタンフォード/g' \
                -e 's/Washington.*/ワシントン/g'
              )

              echo "$LOCATION"

              set -e inside
            end
          end

          get_mullvad_status
          set initialized true

          ${pkgs.inotify-tools}/bin/inotifywait -q -e close_write,moved_to,create -m /etc/mullvad-vpn |
          while read directory events filename
            get_mullvad_status
          end
        '';
    };

    ${volumeScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          sleep 2

          ~/.config/${volumeGet}

          pactl subscribe | grep --line-buffered -e "シンク" | xargs -L 1 ~/.config/${volumeGet}
        '';
    };

    ${volumeGet} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          set VOL $(wpctl get-volume @DEFAULT_AUDIO_SINK@)
          set MUTE $(echo "$VOL" | awk '{print $3}' | sed -e 's/\[MUTED\]/（ミュート）/' | tr --delete '\n')

          echo -n "$MUTE"
          echo "音量：$(math "$(echo "$VOL" | choose 1) * 100")%"
        '';
    };
  };
}
