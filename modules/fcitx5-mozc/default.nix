{pkgs, ...}: {
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = [pkgs.fcitx5-mozc];

  home-manager.sharedModules = [
    {
      xdg.configFile = {
        "mozc/ibus_config.textproto" = {
          force = true;
          source = ./ibus_config.textproto;
        };
        "fcitx5/config" = {
          force = true;
          source = ./config;
        };
        "fcitx5/profile" = {
          force = true;
          source = ./profile;
        };
        "fcitx5/conf/classicui.conf" = {
          force = true;
          source = ./classicui.conf;
        };
        "fcitx5/conf/clipboard.conf" = {
          force = true;
          source = ./clipboard.conf;
        };
        "fcitx5/conf/mozc.conf" = {
          force = true;
          source = ./mozc.conf;
        };
        "fcitx5/conf/notifications.conf" = {
          force = true;
          text = "HiddenNotifications=";
        };
        "fcitx5/conf/unicode.conf" = {
          force = true;
          text = "TriggerKey=";
        };
      };
    }
  ];
}
