{ config, ... }:

let
  inherit (config.home) homeDirectory;
in
{
  xdg = {
    desktopEntries = {
      htop = {
        name = "htop";
        noDisplay = true;
      };

      fish = {
        name = "fish";
        noDisplay = true;
      };

      nvim = {
        name = "nvim";
        noDisplay = true;
      };

      yazi = {
        name = "yazi";
        noDisplay = true;
      };

      tectonic = {
        name = "tectonic";
        noDisplay = true;
      };
    };

    userDirs = {
      enable = true;
      createDirectories = true;

      desktop = null;
      templates = null;
      publicShare = null;

      download = "${homeDirectory}/ダウンロード";
      documents = "${homeDirectory}/ドキュメント";
      music = "${homeDirectory}/音楽";
      pictures = "${homeDirectory}/画像";
      videos = "${homeDirectory}/ビデオ";
    };

    configFile."user-dirs.locale".text = "ja_JP";
  };
}
