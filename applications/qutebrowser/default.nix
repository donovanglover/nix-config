{ pkgs, ... }:

{
  home-manager.sharedModules = [{
    programs.qutebrowser = {
      enable = true;
      package = pkgs.qutebrowser-qt6;
      extraConfig = ''
        # Mute tabs by default
        from qutebrowser.mainwindow import tabwidget
        tabwidget.TabWidget.MUTE_STRING = ""
        tabwidget.TabWidget.AUDIBLE_STRING = "[A]"

        # Don't close while browsing / downloading
        c.confirm_quit = ['multiple-tabs', 'downloads']

        # Restore previous tabs
        c.session.lazy_restore = True

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

        # Make new tab position more sane
        c.tabs.new_position.unrelated = 'next'

        # Download settings
        c.downloads.location.directory = "$HOME/Downloads"
        c.downloads.location.prompt = False
        c.downloads.position = "bottom"
        c.downloads.remove_finished = 5000

        # Only show tabs when multiple are open
        c.tabs.show = "multiple"

        # Don't switch tabs with mouse
        c.tabs.mousewheel_switching = False

        # Edit text with neovim
        c.editor.command = ['kitty', '-e', 'nvim', '{}']

        # Use J/K for prev/next
        config.bind('J', 'tab-prev')
        config.bind('K', 'tab-next')

        # Use F12 for devtools
        config.bind('<F12>', 'devtools')

        # Use zb to delete bookmarks
        config.bind('zb', 'bookmark-del')

        # Increase the default scroll offset of j/k
        # NOTE: Unfortunately this breaks websites that use their own keybinds for j/k/etc
        # config.bind('j', 'run-with-count 5 scroll down')
        # config.bind('k', 'run-with-count 5 scroll up')

        # NOTE: Use with smooth smooth scrolling enabled to scroll smoothly
        # config.bind('d', 'run-with-count 12 scroll down')
        # config.bind('u', 'run-with-count 12 scroll up')

        # Use d/u to scroll down/up
        config.bind('d', 'scroll-page 0 0.5')
        config.bind('u', 'scroll-page 0 -0.5')
        config.bind('D', 'scroll-page 0 0.5')
        config.bind('U', 'scroll-page 0 -0.5')

        # Use alt+left/right to go back/forward
        config.bind('<Alt+Left>', 'back')
        config.bind('<Alt+Right>', 'forward')

        # Use x to close tabs and X to undo
        config.bind('x', 'tab-close')
        config.bind('X', 'undo')

        # Toggle tab visibility for more screen space
        config.bind('st', 'config-cycle tabs.show multiple switching')

        # Easily change the position of tabs
        config.bind('sTh', 'set tabs.position left')
        config.bind('sTj', 'set tabs.position bottom')
        config.bind('sTk', 'set tabs.position top')
        config.bind('sTl', 'set tabs.position right')

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

        # Support previous/next tab with traditional keybinds
        config.bind('<Ctrl+Shift+Tab>', 'tab-prev')
        config.bind('<Ctrl+Tab>', 'tab-next')

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
        # config.bind('<Return>', 'command-accept;; set statusbar.show in-mode', mode='command')

        # Easily start a new temporary container
        config.bind(';s', 'hint links spawn ~/.local/bin/tmp {hint-url}')

        # Open the current tab / selected link in mpv
        config.bind('zM', 'spawn mpv --force-window=immediate {url}')
        config.bind('zm', 'hint links spawn mpv --force-window=immediate {hint-url}')

        # Automatically mute tabs
        c.content.mute = True

        # Use proxy websites for popular services
        config.bind('zu', 'hint links spawn -u untrack-url -O {hint-url}')

        # Enable expected permissions to avoid websites asking every time
        c.content.persistent_storage = True
        c.content.notifications.enabled = True
        c.content.register_protocol_handler = True

        # Hide the window title bar on GNOME
        # NOTE: This is no longer necessary since GNOME has an extension called
        #       pixel-saver that # automatically handles this for us, and without
        #       the downsides of not having a window bar.
        # c.window.hide_decoration = True

        # Close qutebrowser when there are no tabs left
        c.tabs.last_close = "close"

        # Don't automatically enter/leave insert mode
        # NOTE: This was originally done to prevent insert mode from prematurely exiting
        #       in certain # cases (such as mouse usage), although keeping auto functionality
        #       seems to be more useful # long-term.
        c.input.insert_mode.auto_enter = False
        c.input.insert_mode.auto_leave = False

        # Prioritize Japanese content (en-US is necessary to avoid breaking things)
        c.content.headers.accept_language = 'ja-JP,en-US'
      '';
    };
  }];
}
