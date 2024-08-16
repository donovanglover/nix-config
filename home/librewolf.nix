{ pkgs, firefox-addons, ... }:

let
  friendlyfox = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "mobile-friendly-firefox";
    version = "2.11.1";

    src = pkgs.fetchFromGitea {
      domain = "codeberg.org";
      owner = "user0";
      repo = "Mobile-Friendly-Firefox";
      rev = "v${finalAttrs.version}";
      hash = "sha256-rA5lnfW5zOyfJ6pbcrsTBEhMEof5h/heGaHxST+q+AY=";
    };

    patches = [
      # Fix for Firefox 127 and later (renamed id)
      (pkgs.fetchpatch2 {
        url = "https://codeberg.org/user0/Mobile-Friendly-Firefox/commit/bfb7946973bf707d0494714679df47ec66017f97.patch";
        hash = "sha256-wJLXgNUUaNHVgCMi8sGnC5cx2yNwZwh2JoDaVMsVehY=";
      })
    ];

    installPhase = ''
      runHook preInstall

      install -Dm644 src/userContent/styles/fenix-colors/userContent.css -t $out
      cat src/userChrome/fenix_one.css src/userChrome/dynamic_popups_pro.css > $out/userChrome.css

      runHook postInstall
    '';
  });
in
{
  programs.librewolf = {
    enable = true;

    package = pkgs.librewolf.override { cfg.speechSynthesisSupport = false; };

    profiles.default = {
      extensions = with firefox-addons.packages.${pkgs.system}; [
        yomitan
      ];

      search = {
        force = true;
        default = "Mullvad";
        privateDefault = "Mullvad";

        engines = {
          Mullvad = {
            urls = [ { template = "https://leta.mullvad.net/?q={searchTerms}"; } ];
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

  home.file = {
    ".librewolf/default/chrome/userChrome.css".source = "${friendlyfox}/userChrome.css";
    ".librewolf/default/chrome/userContent.css".source = "${friendlyfox}/userContent.css";
  };
}
