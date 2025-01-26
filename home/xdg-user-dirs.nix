{ config, ... }:

let
  inherit (config.home) homeDirectory;
in
{
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;

      templates = null;
      publicShare = null;

      desktop = homeDirectory;
      download = "${homeDirectory}/ダウンロード";
      documents = "${homeDirectory}/ドキュメント";
      music = "${homeDirectory}/音楽";
      pictures = "${homeDirectory}/画像";
      videos = "${homeDirectory}/ビデオ";
    };

    configFile."user-dirs.locale".text = "ja_JP";
  };
}
