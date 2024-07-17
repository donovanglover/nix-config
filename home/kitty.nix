{ config, ... }:

let
  inherit (config.lib.stylix.colors) base00;
in
{
  programs.kitty = {
    enable = true;

    settings = {
      enable_audio_bell = false;
      close_on_child_death = true;
      cursor_blink_interval = 0;

      enabled_layouts = "fat, tall, vertical";
      wayland_titlebar_color = "background";

      allow_remote_control = true;
      listen_on = "unix:/tmp/kitty";
      dynamic_background_opacity = true;

      window_padding_width = 5;
      tab_bar_margin_width = 5;

      scrollback_pager = "less --chop-long-lines --raw-control-chars +INPUT_LINE_NUMBER";
    };

    extraConfig = ''
      tab_bar_background #${base00}
      inactive_tab_background #${base00}
      map F1 send_text all \x1afg;notify-send "$(pwd)" "Task Completed."\r
    '';
  };

  xdg.configFile."kitty/diff.conf".text = ''
    map d scroll_to next-page
    map u scroll_to prev-page
    map g scroll_to start
    map G scroll_to end
  '';
}
