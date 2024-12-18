{ lib, pkgs, ... }:

{
  programs.mpv = {
    enable = true;

    config = {
      video-sync = "display-resample";
      interpolation = true;
      tscale = "oversample";
      fullscreen = true;

      sub-auto = "fuzzy";
      sub-font = "Noto Sans CJK JP Medium";
      sub-blur = 10;
      sub-file-paths = "subs:subtitles:字幕";

      screenshot-format = "png";

      title = "\${filename} - mpv";
      script-opts = "osc-title=\${filename},osc-boxalpha=150,osc-visibility=never,osc-boxvideo=yes";

      osc = "no";
      osd-on-seek = "no";
      osd-bar = "no";
      osd-bar-w = 30;
      osd-bar-h = "0.2";
      osd-duration = 750;

      really-quiet = "yes";
      autofit = "65%";
    };

    bindings = {
      "ctrl+a" = "script-message osc-visibility cycle";
    };

    scripts = with pkgs.mpvScripts; [
      mpris
      uosc
      thumbfast
    ];
  };

  xdg.configFile."mpv/script-opts/uosc.conf".text = lib.concatStrings [
    "opacity="
    ",timeline=0.1"
    ",position=0.1"
    ",chapters=0.1"
    ",slider=0.1"
    ",slider_gauge=0.1"
    ",controls=0.1"
    ",speed=0.1"
    ",menu=0.1"
    ",submenu=0.1"
    ",border=0.1"
    ",title=0.1"
    ",tooltip=0.1"
    ",thumbnail=0.1"
    ",curtain=0.1"
    ",idle_indicator=0.1"
    ",audio_indicator=0.1"
    ",buffering_indicator=0.1"
    ",playlist_position=0.1"
  ];
}
