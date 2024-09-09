{ config, nixosConfig, ... }:

let
  inherit (config.home) homeDirectory;

  isPhone = nixosConfig.programs.calls.enable;
in
{
  xdg = {
    userDirs = {
      enable = true;
      createDirectories = true;

      templates = null;
      publicShare = null;

      desktop = homeDirectory;
      download = if isPhone then homeDirectory else "${homeDirectory}/ダウンロード";
      documents = if isPhone then homeDirectory else "${homeDirectory}/ドキュメント";
      music = if isPhone then homeDirectory else "${homeDirectory}/音楽";
      pictures = if isPhone then homeDirectory else "${homeDirectory}/画像";
      videos = if isPhone then homeDirectory else "${homeDirectory}/ビデオ";
    };

    configFile."user-dirs.locale".text = "ja_JP";
  };
}
