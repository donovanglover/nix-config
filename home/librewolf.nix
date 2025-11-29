{
  pkgs,
  lib,
  nixosConfig,
  ...
}:

let
  inherit (nixosConfig._module.specialArgs) nix-config;

  inherit (lib) singleton;

  search = {
    force = true;
    default = "Mullvad";
    privateDefault = "Mullvad";

    engines = {
      Mullvad = {
        urls = singleton {
          template = "https://leta.mullvad.net";

          params = singleton {
            name = "q";
            value = "{searchTerms}";
          };
        };

        icon = "${pkgs.mullvad-vpn}/share/icons/hicolor/32x32/apps/mullvad-vpn.png";
      };

      "excite.co.jp" = {
        urls = singleton {
          template = "https://websearch.excite.co.jp";

          params = singleton {
            name = "q";
            value = "{searchTerms}";
          };
        };

        icon = pkgs.fetchurl {
          url = "https://s.eximg.jp/search/images/lep.ico";
          hash = "sha256-mUnVTRrpDFAcXtC8YPmHUCICr/cYF0FNYkBBHedZReE=";
        };
      };

      google.metaData.hidden = true;
      bing.metaData.hidden = true;
      ddg.metaData.hidden = true;
      wikipedia.metaData.hidden = true;
    };
  };

  settings = {
    "extensions.autoDisableScopes" = 0;

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

    "apz.overscroll.enabled" = false;
    "browser.tabs.hoverPreview.enabled" = true;

    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
  };
in
{
  stylix.targets.librewolf.profileNames = [ "default" ];

  programs.librewolf = {
    enable = true;

    package = pkgs.librewolf.override {
      cfg.speechSynthesisSupport = false;
    };

    languagePacks = [ "ja" ];

    profiles = {
      default = {
        extensions.packages = with nix-config.packages.${pkgs.system}; [
          new-tab-identity
        ];

        inherit settings search;
      };

      work = {
        id = 1;

        inherit settings search;
      };
    };
  };
}
