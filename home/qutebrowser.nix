{
  programs.qutebrowser = {
    enable = true;

    settings = {
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
        folder.command = [ "kitty" "-e" "yazi" "--cwd-file" "{}" ];
        multiple_files.command = [ "kitty" "-e" "yazi" "--chooser-file" "{}" ];
        single_file.command = [ "kitty" "-e" "yazi" "--chooser-file" "{}" ];
      };

      downloads = {
        location.directory = "$HOME/ダウンロード";
        location.prompt = false;
        position = "bottom";
        remove_finished = 5000;
      };

      qt = {
        args = [ "disable-backing-store-limit" "enable-accelerated-video-decode" "disable-gpu-driver-bug-workarounds" ];
        chromium.low_end_device_mode = "never";
      };

      editor.command = [ "kitty" "-e" "nvim" "{}" ];
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
      };
    };

    extraConfig = /* python */ ''
      from qutebrowser.mainwindow import tabwidget

      tabwidget.TabWidget.MUTE_STRING = ""
      tabwidget.TabWidget.AUDIBLE_STRING = "[A]"

      c.colors.contextmenu.disabled.fg = '#808080'
      c.colors.contextmenu.menu.bg = '#353535'
      c.colors.contextmenu.menu.fg = '#ffffff'
      c.colors.contextmenu.selected.bg = '#909090'

      c.colors.webpage.darkmode.enabled = False

      config.unbind('pp', mode='normal')
      config.unbind('pP', mode='normal')
      config.unbind('Pp', mode='normal')
      config.unbind('PP', mode='normal')
      config.unbind('wp', mode='normal')
      config.unbind('wP', mode='normal')

      config.bind('zl', 'spawn --userscript qute-pass')
      config.bind('zpl', 'spawn --userscript qute-pass --password-only')
      config.bind('zol', 'spawn --userscript qute-pass --otp-only')

      config.bind('zM', 'spawn mpv --force-window=immediate {url}')
      config.bind('zm', 'hint links spawn mpv --force-window=immediate {hint-url}')

      c.url.start_pages = ['about:blank']
      c.url.default_page = "about:blank"
      c.url.searchengines = {
        'DEFAULT': 'https://search.goo.ne.jp/web.jsp?MT={}'
      }
    '';
  };
}
