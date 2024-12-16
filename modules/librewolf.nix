{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    package = pkgs.librewolf;

    policies = {
      ExtensionSettings = {
        "showdex@tize.io" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/showdex/latest.xpi";
          installation_mode = "force_installed";
        };

        "{6b733b82-9261-47ee-a595-2dda294a4d08}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/yomitan/latest.xpi";
          installation_mode = "force_installed";
        };

        "{5003e502-f361-4bf6-b09e-41a844d36d33}" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/redlib/latest.xpi";
          installation_mode = "force_installed";
        };

        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
      };
    };
  };
}
