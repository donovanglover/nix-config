{
  pkgs,
  lib,
  nix-config,
  phone,
  ...
}:

let
  inherit (lib) mkIf singleton;
  inherit (nix-config.packages.${pkgs.system}) friendlyfox;
in
{
  programs.librewolf = {
    enable = true;

    package = pkgs.librewolf.override {
      cfg.speechSynthesisSupport = false;
    };

    profiles.default = {
      extensions = with nix-config.packages.${pkgs.system}; [
        ublock-origin
        yomitan
        redlib
        new-tab-identity
        showdex
      ];

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

          "goo.ne.jp" = {
            urls = singleton {
              template = "https://search.goo.ne.jp/web.jsp";

              params = singleton {
                name = "MT";
                value = "{searchTerms}";
              };
            };

            icon = pkgs.fetchurl {
              url = "https://search.goo.ne.jp/favicon.ico";
              hash = "sha256-luYqjziIpHgIJPbryjFjera3Fdbbj/fO6SNyDbnEZj0=";
            };
          };
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

        "network.dns.native_https_query" = false;

        "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
      };
    };
  };

  home.file = mkIf phone {
    ".librewolf/default/chrome/userChrome.css".source = "${friendlyfox}/userChrome.css";
    ".librewolf/default/chrome/userContent.css".source = "${friendlyfox}/userContent.css";
  };
}
