{ config, pkgs, ... }:

let
  barScript = "dwm/bar.fish";
in
{
  home = {
    packages = with pkgs; [
      feh
      xclip
      scrot
    ];

    file.".xinitrc" = {
      executable = true;
      text = # bash
        ''
          #!/usr/bin/env sh

          export XDG_SESSION_TYPE=x11
          export GDK_BACKEND=x11
          export XDG_CURRENT_DESKTOP=dwm
          export GTK_IM_MODULE=fcitx
          export QT_IM_MODULE=fcitx
          export XMODIFIERS=@im=fcitx
          export SDL_IM_MODULE=fcitx
          export GLFW_IM_MODULE=ibus
          export GTK_CSD=0

          xrdb -merge ~/.Xresources
          xset r rate 300 50
          feh --no-fehbg --bg-scale ${config.stylix.image}
          ~/.config/${barScript} &
          picom --daemon
          ${pkgs.nemo}/bin/nemo-desktop &
          fcitx5 &

          while true; do
            dbus-launch --sh-syntax --exit-with-session dwm
          done
        '';
    };
  };

  xdg.configFile = {
    ${barScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          function get_icon
            if test "$argv" -gt 90
              echo " "
            else if test "$argv" -gt 60
              echo " "
            else if test "$argv" -gt 30
              echo " "
            else if test "$argv" -gt 10
              echo " "
            else
              echo " "
            end
          end

          function update_bar
            set VOLUME "音量：$(math "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | choose 1) * 100")%"
            set TIME "$(date '+%x（%a）%R')"
            set capacity "$(cat /sys/class/power_supply/BAT0/capacity)"

            set BATTERY "$(get_icon $capacity)$capacity%"

            xsetroot -name " $VOLUME・$BATTERY・$TIME "
          end

          while true
            update_bar

            sleep 10s
          end
        '';
    };
  };
}
