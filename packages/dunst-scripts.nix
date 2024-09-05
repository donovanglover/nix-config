{
  lib,
  stdenvNoCC,
  writeTextFile,
  makeWrapper,
  fish,
  pipewire,
  brightnessctl,
  libnotify,
}:

let
  volume = writeTextFile {
    name = "volume";
    text = # fish
      ''
        #!/usr/bin/env fish

        wpctl set-volume --limit 1 @DEFAULT_AUDIO_SINK@ 5%+

        set VOL "$(wpctl get-volume '@DEFAULT_AUDIO_SINK@')"

        notify-send \
          --icon "multimedia-volume-control" \
          --hint "string:x-dunst-stack-tag:volume" \
          --hint "int:value:$(math "$(echo "$VOL" | awk '{print $2}') * 100")" \
          "音量" \
          "$(echo "$VOL" | awk '{print $3}' | sed -e 's/\[MUTED\]/ミュート/' | tr --delete '\n')"
      '';
  };

  brightness = writeTextFile {
    name = "brightness";
    text = # fish
      ''
        #!/usr/bin/env fish

        notify-send \
          --icon "brightness" \
          --hint "string:x-dunst-stack-tag:brightness" \
          --hint "int:value:$(brightnessctl set 5%+ -m | awk --field-separator , '{print $4}')" \
          "明るさ"
      '';
  };
in
stdenvNoCC.mkDerivation {
  pname = "dunst-scripts";
  version = "0.1.0";

  dontUnpack = true;

  nativeBuildInputs = [ makeWrapper ];

  installPhase = ''
    runHook preInstall

    install -Dm755 ${brightness} $out/bin/mb-up
    install -Dm755 ${brightness} $out/bin/mb-down
    install -Dm755 ${volume} $out/bin/mv-up
    install -Dm755 ${volume} $out/bin/mv-down
    install -Dm755 ${volume} $out/bin/mv-mute

    substituteInPlace $out/bin/mb-down \
      --replace-fail "5%+" "5%-"

    substituteInPlace $out/bin/mv-down \
      --replace-fail "5%+" "5%-"

    substituteInPlace $out/bin/mv-mute \
      --replace-fail "set-volume --limit 1" "set-mute" \
      --replace-fail "5%+" "toggle"

    install -Dm755 $out/bin/mv-mute $out/bin/mv-mic

    substituteInPlace $out/bin/mv-mic \
      --replace-fail "DEFAULT_AUDIO_SINK" "DEFAULT_AUDIO_SOURCE" \
      --replace-fail "multimedia-volume-control" "audio-input-microphone" \
      --replace-fail "x-dunst-stack-tag:volume" "x-dunst-stack-tag:microphone" \
      --replace-fail "音量" "マイク"

    runHook postInstall
  '';

  postInstall = ''
    for bin in $out/bin/*; do
      wrapProgram "$bin" \
        --prefix PATH ":" "${
          lib.makeBinPath [
            fish
            pipewire
            brightnessctl
            libnotify
          ]
        }"
    done
  '';

  meta = {
    homepage = "https://github.com/donovanglover/nix-config";
    description = "Dunst scripts for brightness and volume";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.linux;
  };
}
