let
  VARIABLES = import ../../src/variables.nix;
in
{
  home-manager.sharedModules = [
    {
      xdg.userDirs = {
        enable = true;

        desktop = null;
        templates = null;
        publicShare = null;

        download = "/home/${VARIABLES.username}/ダウンロード";
        documents = "/home/${VARIABLES.username}/ドキュメント";
        music = "/home/${VARIABLES.username}/音楽";
        pictures = "/home/${VARIABLES.username}/画像";
        videos = "/home/${VARIABLES.username}/ビデオ";
      };

      xdg.configFile."user-dirs.locale".text = "ja_JP";
    }
  ];
}
