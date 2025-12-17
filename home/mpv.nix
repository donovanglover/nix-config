{
  lib,
  pkgs,
  nixosConfig,
  ...
}:

let
  inherit (nixosConfig._module.specialArgs) nix-config;

  inherit (lib) getExe;
  inherit (nix-config.packages.${pkgs.stdenv.hostPlatform.system}) mpv-websocket;

  input-ipc-server = "/tmp/mpv-socket";
in
{
  programs.mpv = {
    enable = true;

    package = pkgs.mpv-unwrapped.wrapper {
      mpv = pkgs.mpv-unwrapped.override {
        ffmpeg = pkgs.ffmpeg-full;
      };

      scripts = with pkgs.mpvScripts; [
        mpris
        uosc
        thumbfast
      ];
    };

    config = {
      fullscreen = true;

      screenshot-format = "png";

      title = "\${filename} - mpv";
      script-opts = "osc-title=\${filename},osc-boxalpha=150,osc-visibility=never,osc-boxvideo=yes";

      osc = "no";
      osd-on-seek = "no";
      osd-bar = "no";
      osd-bar-w = 30;
      osd-bar-h = "0.2";
      osd-duration = 750;

      autofit = "65%";

      slang = "jp,jpn,japanese";
      subs-fallback = false;

      inherit input-ipc-server;
    };

    bindings = {
      "ctrl+a" = "script-message osc-visibility cycle";
      "ctrl+b" = "apply-profile fast";
      "ctrl+f" = "script-binding subtitle_lines/list_subtitles";
      "Del" = "run \"trash\" \"\${path}\"; playlist_next";
    };
  };

  xdg.configFile = {
    "mpv/scripts/run_websocket_server.lua".text = # lua
      ''
        mp.command_native_async({
          name = "subprocess",
          playback_only = false,
          capture_stdout = true,
          capture_stderr = true,

          args = {
            "${getExe mpv-websocket}",
            "-m",
            "${input-ipc-server}",
            "-w",
            "6677",
          },
        })
      '';

    "mpv/script-opts/uosc.conf".text = lib.concatStrings [
      "opacity="
      ",timeline=0.1"
      ",position=0.2"
      ",chapters=0.075"
      ",slider=0.1"
      ",slider_gauge=0.2"
      ",controls=0"
      ",speed=0.2"
      ",menu=1"
      ",submenu=0.4"
      ",border=1"
      ",title=1"
      ",tooltip=1"
      ",thumbnail=1"
      ",curtain=0.8"
      ",idle_indicator=0.8"
      ",audio_indicator=0.5"
      ",buffering_indicator=0.3"
      ",playlist_position=0.8"
    ];
  };
}
