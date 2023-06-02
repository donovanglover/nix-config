{
  home-manager.sharedModules = [{
    xdg.userDirs = {
      enable = true;

      desktop = null;
      templates = null;
      publicShare = null;

      download = "/home/user/ダウンロード";
      documents = "/home/user/ドキュメント";
      music = "/home/user/音楽";
      pictures = "/home/user/画像";
      videos = "/home/user/ビデオ";
    };

    xdg.configFile."user-dirs.locale".text = "ja_JP";
  }];
}
