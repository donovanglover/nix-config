{ pkgs, lib, ... }:

let
  inherit (lib.gvariant) mkTuple mkUint32;
in
{
  dconf.settings = {
    "sm/puri/phosh" = {
      app-filter-mode = [ ];
      enable-suspend = true;

      favorites = [
        "org.gnome.Calls.desktop"
        "sm.puri.Chatty.desktop"
        "kitty.desktop"
        "librewolf.desktop"
      ];
    };

    "sm/puri/phosh/lockscreen" = {
      shuffle-keypad = true;
    };

    "sm/puri/phosh/plugins" = {
      quick-settings = [
        "night-light-quick-setting"
        "caffeine-quick-setting"
      ];
    };

    "org/gnome/desktop/interface" = {
      show-battery-percentage = true;
    };

    "org/postmarketos/megapixels" = {
      save-raw = false;
      postprocessor = "${pkgs.megapixels}/share/megapixels/postprocess.sh";
    };

    "org/gnome/desktop/session" = {
      idle-delay = mkUint32 60;
    };

    "org/gnome/desktop/input-sources" = {
      sources = [
        (mkTuple [
          "xkb"
          "us"
        ])

        (mkTuple [
          "xkb"
          "jp+kana"
        ])
      ];
    };

    "org/gnome/eog/ui" = {
      image-gallery = true;
      sidebar = false;
    };

    "org/gnome/settings-daemon/plugins/power" = {
      sleep-inactive-ac-type = "nothing";
      sleep-inactive-battery-type = "suspend";
    };
  };
}
