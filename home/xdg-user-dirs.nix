{ config, phone, ... }:

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

      desktop = "${homeDirectory}";
      download = if phone then "${homeDirectory}" else "${homeDirectory}/ダウンロード";
      documents = if phone then "${homeDirectory}" else "${homeDirectory}/ドキュメント";
      music = if phone then "${homeDirectory}" else "${homeDirectory}/音楽";
      pictures = if phone then "${homeDirectory}" else "${homeDirectory}/画像";
      videos = if phone then "${homeDirectory}" else "${homeDirectory}/ビデオ";
    };

    configFile."user-dirs.locale".text = "ja_JP";
  };
}
