{
  home-manager.sharedModules = [
    {
      programs.librewolf = {
        enable = true;

        settings = {
          "middlemouse.paste" = false;

          "ui.use_activity_cursor" = true;

          "privacy.resistFingerprinting.letterboxing" = true;

          "browser.download.useDownloadDir" = true;
          "browser.tabs.insertAfterCurrent" = true;
          "browser.toolbars.bookmarks.visibility" = "never";

          "sidebar.position_start" = false;
        };
      };
    }
  ];
}
