{ pkgs, ... }:

let
  quantum = 64;
  rate = 48000;
  qr = "${toString quantum}/${toString rate}";
  json = pkgs.formats.json { };
in
{
  services.pipewire = {
    enable = true;

    alsa = {
      enable = true;
      support32Bit = true;
    };

    pulse.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pulseaudio
  ];

  security.rtkit.enable = true;

  environment.etc = {
    "pipewire/pipewire.d/99-lowlatency.conf".source = json.generate "99-lowlatency.conf" {
      context.properties.default.clock.min-quantum = quantum;
    };

    "pipewire/pipewire-pulse.d/99-lowlatency.conf".source = json.generate "99-lowlatency.conf" {
      context.modules = [
        {
          name = "libpipewire-module-rtkit";
          args = {
            nice.level = -15;
            rt.prio = 88;
            rt.time.soft = 200000;
            rt.time.hard = 200000;
          };
          flags = [ "ifexists" "nofail" ];
        }
        {
          name = "libpipewire-module-protocol-pulse";
          args = {
            pulse.min.req = qr;
            pulse.min.quantum = qr;
            pulse.min.frag = qr;
            server.address = [ "unix:native" ];
          };
        }
      ];

      stream.properties = {
        node.latency = qr;
        resample.quality = 1;
      };
    };

    "wireplumber/main.lua.d/99-alsa-lowlatency.lua".text = /* lua */ ''
      alsa_monitor.rules = {
        {
          matches = {{{ "node.name", "matches", "alsa_output.*" }}};
          apply_properties = {
            ["audio.format"] = "S32LE",
            ["audio.rate"] = ${toString (rate * 2)},
            ["api.alsa.period-size"] = 2,
          },
        },
      }
    '';
  };
}
