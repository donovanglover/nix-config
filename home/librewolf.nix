{ pkgs, ... }:

{
  programs.librewolf = {
    enable = true;

    package = pkgs.librewolf.override { cfg.speechSynthesisSupport = false; };

    profiles.default = {
      search = {
        force = true;
        default = "Mullvad";
        privateDefault = "Mullvad";

        engines = {
          Mullvad = {
            urls = [{ template = "https://leta.mullvad.net/?q={searchTerms}"; }];
            icon = "${pkgs.mullvad-vpn}/share/icons/hicolor/32x32/apps/mullvad-vpn.png";
          };
        };
      };
    };

    settings = {
      "middlemouse.paste" = false;

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
      "browser.urlbar.trimHttps" = true;

      "sidebar.position_start" = false;
      "findbar.highlightAll" = true;

      "xpinstall.signatures.required" = false;

      "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    };
  };
}
