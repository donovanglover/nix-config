{ config, ... }: {
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "image/png" = "feh.desktop";
      "image/jpeg" = "feh.desktop";
      "image/gif" = "org.qutebrowser.qutebrowser.desktop";
      "application/x-wine-extension-osz" = "osu-stable.desktop";
      "x-scheme-handler/http" = "${config.variables.defaultBrowser}.desktop";
      "x-scheme-handler/https" = "${config.variables.defaultBrowser}.desktop";
    };
  };
}
