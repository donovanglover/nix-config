{
  programs.librewolf = {
    enable = true;

    settings = {
      "middlemouse.paste" = false;

      "ui.use_activity_cursor" = true;

      "browser.download.useDownloadDir" = true;
      "browser.tabs.insertAfterCurrent" = true;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.quitShortcut.disabled" = true;
      "browser.urlbar.suggest.history" = false;

      "sidebar.position_start" = false;
      "findbar.highlightAll" = true;
    };
  };
}
