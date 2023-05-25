{
  home-manager.sharedModules = [{
    programs.librewolf = {
      enable = true;
      settings = {
        "middlemouse.paste" = false;
        "browser.download.useDownloadDir" = true;
        "ui.use_activity_cursor" = true;
        "browser.tabs.insertAfterCurrent" = true;
        "browser.toolbars.bookmarks.visibility" = "never";
      };
    };
  }];
}
