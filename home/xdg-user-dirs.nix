{ config, ... }: {
  xdg.userDirs = {
    enable = true;

    desktop = null;
    templates = null;
    publicShare = null;

    download = "/home/${config.variables.username}/ダウンロード";
    documents = "/home/${config.variables.username}/ドキュメント";
    music = "/home/${config.variables.username}/音楽";
    pictures = "/home/${config.variables.username}/画像";
    videos = "/home/${config.variables.username}/ビデオ";
  };

  xdg.configFile."user-dirs.locale".text = "ja_JP";
}
