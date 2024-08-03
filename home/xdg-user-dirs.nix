{ config, ... }:

let
  inherit (config.home) homeDirectory;

  no = {
    name = "";
    noDisplay = true;
  };
in
{
  xdg = {
    desktopEntries = {
      htop = no;
      fish = no;
      nvim = no;
      yazi = no;
      gcdemu = no;
      tectonic = no;
      mullvad-vpn = no;
      nixos-manual = no;
      image-analyzer = no;
      activate-linux = no;

      thunar-settings = no;
      thunar-bulk-rename = no;
      thunar-volman-settings = no;

      fcitx5-configtool = no;

      base = no;
      calc = no;
      draw = no;
      math = no;
      writer = no;
      impress = no;
      startcenter = no;

      "org.fcitx.Fcitx5" = no;
      "org.fcitx.fcitx5-migrator" = no;
      "org.gnome.Extensions" = no;
      "org.pwmt.zathura" = no;
      "org.gnome.eog" = no;
      "org.gnome.Settings" = no;
      "org.sigxcpu.Livi" = no;
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
