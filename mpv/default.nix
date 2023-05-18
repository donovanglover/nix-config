{ pkgs, ... }:

{
  home-manager.sharedModules = [{
    programs.mpv = {
      enable = true;
      config = {
        screenshot-format = "png";
        profile = "gpu-hq";
        scale = "ewa_lanczossharp";
        cscale = "ewa_lanczossharp";
        video-sync = "display-resample";
        interpolation = true;
        tscale = "oversample";
        sub-auto = "fuzzy";
        sub-font = "Noto Sans CJK JP Medium";
        sub-blur = 10;
        sub-file-paths = "subs:subtitles:字幕";
        fullscreen = "yes";
        title = "\${filename} - mpv";
        script-opts =
          "osc-title=\${filename},osc-boxalpha=150,osc-showfullscreen=no,osc-boxvideo=yes";
        osc = "no";
        osd-on-seek = "no";
        osd-bar = "no";
        osd-bar-w = 30;
        osd-bar-h = "0.2";
        osd-duration = 750;
        really-quiet = "yes";
      };
      scripts = [ pkgs.mpvScripts.thumbnail ];
    };
  }];
}
