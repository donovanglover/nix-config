{ config, pkgs, ... }:

let
  inherit (config.xdg.userDirs) music;

  musicDirectory = music;
in
{
  home.packages = with pkgs; [ rmpc ];

  services.mpd = {
    enable = true;
    inherit musicDirectory;

    extraConfig = ''
      audio_output {
        type "pipewire"
        name "PipeWire Sound Server"
      }

      auto_update "yes"
    '';
  };
}
