{pkgs, ...}: {
  home-manager.sharedModules = [
    {
      programs.qutebrowser = {
        enable = true;
        package = pkgs.qutebrowser-qt6;

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
            headers.accept_language = "ja-JP,en-US";
          };

          editor.command = ["kitty" "-e" "nvim" "{}"];
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

        extraConfig = ''
          # Mute tabs by default
          from qutebrowser.mainwindow import tabwidget
          tabwidget.TabWidget.MUTE_STRING = ""
          tabwidget.TabWidget.AUDIBLE_STRING = "[A]"

          # Use ranger as the file selector
          c.fileselect.handler = 'external'
          c.fileselect.folder.command = ['kitty', '-e', 'ranger', '--choosedir={}']
          c.fileselect.multiple_files.command = ['kitty', '-e', 'ranger', '--choosefiles={}']
          c.fileselect.single_file.command = ['kitty', '-e', 'ranger', '--choosefile={}']

          # Better context menu colors
          c.colors.contextmenu.disabled.fg = '#808080'
          c.colors.contextmenu.menu.bg = '#353535'
          c.colors.contextmenu.menu.fg = '#ffffff'
          c.colors.contextmenu.selected.bg = '#909090'

          # Chromium flags
          c.qt.args = ["disable-backing-store-limit", "enable-accelerated-video-decode", "disable-gpu-driver-bug-workarounds"]
          c.qt.chromium.low_end_device_mode = 'never'

          # Download settings
          c.downloads.location.directory = "$HOME/Downloads"
          c.downloads.location.prompt = False
          c.downloads.position = "bottom"
          c.downloads.remove_finished = 5000

          # Increase the default scroll offset of j/k
          # NOTE: Unfortunately this breaks websites that use their own keybinds for j/k/etc
          # config.bind('j', 'run-with-count 5 scroll down')
          # config.bind('k', 'run-with-count 5 scroll up')

          # NOTE: Use with smooth scrolling enabled to scroll smoothly
          # config.bind('d', 'run-with-count 12 scroll down')
          # config.bind('u', 'run-with-count 12 scroll up')

          # Don't paste something by accident
          config.unbind('pp', mode='normal')
          config.unbind('pP', mode='normal')
          config.unbind('Pp', mode='normal')
          config.unbind('PP', mode='normal')
          config.unbind('wp', mode='normal')
          config.unbind('wP', mode='normal')

          # Easily enter account information
          # NOTE: I re-evaluated pass when I was focusing on a terminal-centric workflow.
          config.bind('zl', 'spawn --userscript qute-pass')
          config.bind('zpl', 'spawn --userscript qute-pass --password-only')
          config.bind('zol', 'spawn --userscript qute-pass --otp-only')

          # Hide the status bar except under exceptional circumstances
          # NOTE: This broke more things than not, which is why I ultimately decided
          #       to always use the status bar. More information can be found in the
          #       following discussion: https://github.com/qutebrowser/qutebrowser/issues/2236
          # config.bind('o', 'set statusbar.show always;; set-cmd-text -s :open')
          # config.bind('O', 'set statusbar.show always;; set-cmd-text -s :open -t')
          # config.bind('T', 'set statusbar.show always;; set-cmd-text -sr :tab-focus')
          # config.bind(':', 'set statusbar.show always;; set-cmd-text :')
          # config.bind('/', 'set statusbar.show always;; set-cmd-text /')
          # config.bind('<Escape>', 'mode-enter normal;; set statusbar.show in-mode', mode='command')
          config.bind('zM', 'spawn mpv --force-window=immediate {url}')
          config.bind('zm', 'hint links spawn mpv --force-window=immediate {hint-url}')

          # Use proxy websites for popular services
          config.bind('zu', 'hint links spawn -u untrack-url -O {hint-url}')

          # Don't automatically enter/leave insert mode
          # NOTE: This was originally done to prevent insert mode from prematurely exiting
          #       in certain # cases (such as mouse usage), although keeping auto functionality
          #       seems to be more useful # long-term.
          c.input.insert_mode.auto_enter = False
          c.input.insert_mode.auto_leave = False

          c.url.start_pages = ['about:blank']
          c.url.default_page = "about:blank"
          c.url.searchengines = {
            'DEFAULT': 'https://search.goo.ne.jp/web.jsp?MT={}'
          }
        '';
      };
    }
  ];
}
