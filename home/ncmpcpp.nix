{ config, ... }:

let
  inherit (config.xdg.userDirs) music;

  musicDirectory = music;
in
{
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
