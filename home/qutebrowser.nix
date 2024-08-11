{ config, ... }:

let
  inherit (config.xdg.userDirs) download;
in
{
  programs.qutebrowser = {
    enable = true;

    settings = {
      url = {
        start_pages = [ "about:blank" ];
        default_page = "about:blank";
      };

      colors.webpage.darkmode.enabled = false;

      confirm_quit = [
        "multiple-tabs"
        "downloads"
      ];

      session.lazy_restore = true;

      tabs = {
        show = "multiple";
        mousewheel_switching = false;
        last_close = "close";
        new_position.unrelated = "next";
      };

      content = {
        persistent_storage = true;
        notifications.enabled = true;
        register_protocol_handler = true;
        mute = true;
        headers.accept_language = "ja,en-US;q=0.9,en;q=0.8";
      };

      fileselect = {
        handler = "external";

        folder.command = [
          "kitty"
          "-e"
          "yazi"
          "--cwd-file"
          "{}"
        ];

        multiple_files.command = [
          "kitty"
          "-e"
          "yazi"
          "--chooser-file"
          "{}"
        ];

        single_file.command = [
          "kitty"
          "-e"
          "yazi"
          "--chooser-file"
          "{}"
        ];
      };

      downloads = {
        location = {
          directory = download;
          prompt = false;
        };

        position = "bottom";
        remove_finished = 5000;
      };

      qt = {
        args = [
          "disable-backing-store-limit"
          "enable-accelerated-video-decode"
          "disable-gpu-driver-bug-workarounds"
        ];

        chromium.low_end_device_mode = "never";
      };

      editor.command = [
        "kitty"
        "-e"
        "nvim"
        "{}"
      ];
    };

    keyBindings = {
      normal = {
        d = "scroll-page 0 0.5";
        u = "scroll-page 0 -0.5";
        D = "scroll-page 0 0.5";
        U = "scroll-page 0 -0.5";
        "<Alt+Left>" = "back";
        "<Alt+Right>" = "forward";
        "<Ctrl+Shift+Tab>" = "tab-prev";
        "<Ctrl+Tab>" = "tab-next";
        J = "tab-prev";
        K = "tab-next";
        "<F12>" = "devtools";
        zb = "bookmark-del";
        x = "tab-close";
        X = "undo";
        st = "config-cycle tabs.show multiple switching";
        sTh = "set tabs.position left";
        sTj = "set tabs.position bottom";
        sTk = "set tabs.position top";
        sTl = "set tabs.position right";

        pp = null;
        pP = null;
        Pp = null;
        PP = null;
        wp = null;
        wP = null;
      };
    };

    searchEngines = {
      DEFAULT = "https://search.goo.ne.jp/web.jsp?MT={}";
    };

    extraConfig = # python
      ''
        from qutebrowser.mainwindow import tabwidget

        tabwidget.TabWidget.MUTE_STRING = ""
        tabwidget.TabWidget.AUDIBLE_STRING = "[A]"
      '';
  };
}
