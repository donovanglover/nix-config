{
  config,
  ...
}:

let
  inherit (config.home) homeDirectory;

  mpvScript = "mpv/x-scheme-handler.fish";
in
{
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "inode/directory" = "thunar.desktop";
      "text/html" = "librewolf.desktop";
      "text/markdown" = "nvim.desktop";
      "text/plain" = "nvim.desktop";
      "text/vnd.trolltech.linguist" = "mpv.desktop";
      "video/mp2t" = "mpv.desktop";
      "image/png" = "pqiv.desktop";
      "image/jpeg" = "pqiv.desktop";
      "image/gif" = "pqiv.desktop";
      "image/webp" = "pqiv.desktop";
      "application/pdf" = "org.pwmt.zathura-pdf-mupdf.desktop";
      "application/x-wine-extension-osz" = "osu-stable.desktop";
      "x-scheme-handler/http" = "librewolf.desktop";
      "x-scheme-handler/https" = "librewolf.desktop";
      "x-scheme-handler/mpv" = "mpv-scheme-handler.desktop";
    };
  };

  xdg.configFile = {
    ${mpvScript} = {
      executable = true;
      text = # fish
        ''
          #!/usr/bin/env fish

          set URL_ESCAPED $(string replace "mpv://" "" $argv[1])
          set URL $(string unescape --style=url $URL_ESCAPED)

          notify-send -i "mpv" "mpv" "Opening $URL"

          mpv --keep-open --player-operation-mode=pseudo-gui "$URL" || notify-send -i "mpv" "mpv" "Failed to open $URL"
        '';
    };
  };

  xdg.dataFile."applications/mpv-scheme-handler.desktop" = {
    text = # desktop
      ''
        [Desktop Entry]
        Version=1.0
        Type=Application
        Exec=fish ${homeDirectory}/.config/${mpvScript} %u
        Icon=mpv
        StartupNotify=true
        Terminal=false
        MimeType=x-scheme-handler/mpv
        Name=MPV Launcher
        Comment=Launch MPV
        Hidden=true
      '';
  };
}
