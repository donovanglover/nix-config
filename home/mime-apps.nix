let VARIABLES = import ../src/variables.nix; in {
  xdg.mimeApps = {
    enable = true;

    defaultApplications = {
      "image/png" = "feh.desktop";
      "image/jpeg" = "feh.desktop";
      "image/gif" = "org.qutebrowser.qutebrowser.desktop";
      "application/x-wine-extension-osz" = "osu-stable.desktop";
      "x-scheme-handler/http" = "${VARIABLES.defaultBrowser}.desktop";
      "x-scheme-handler/https" = "${VARIABLES.defaultBrowser}.desktop";
    };
  };
}
