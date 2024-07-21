{ pkgs, ... }:

let
  inherit (pkgs) librewolf;
in
{
  programs.librewolf = {
    enable = true;

    package = librewolf.override {
      cfg.speechSynthesisSupport = false;
    };

    settings = {
      "middlemouse.paste" = false;

      "ui.use_activity_cursor" = true;

      "browser.download.useDownloadDir" = true;
      "browser.tabs.insertAfterCurrent" = true;
      "browser.tabs.warnOnClose" = true;
      "browser.toolbars.bookmarks.visibility" = "never";
      "browser.quitShortcut.disabled" = true;
      "browser.sessionstore.restore_pinned_tabs_on_demand" = true;

      "browser.urlbar.suggest.bookmark" = false;
      "browser.urlbar.suggest.engines" = false;
      "browser.urlbar.suggest.history" = false;
      "browser.urlbar.suggest.openpage" = false;
      "browser.urlbar.suggest.topsites" = false;

      "sidebar.position_start" = false;
      "findbar.highlightAll" = true;

      "xpinstall.signatures.required" = false;

      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };
  };
}
