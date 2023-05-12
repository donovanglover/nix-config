{ config, lib, nixpkgs, home-manager, hyprland, ... }: {
  users.users.user = {
    isNormalUser = true;
    password = "user";
    extraGroups = [ "wheel" "networkmanager" ];
  };
  imports = [ home-manager.nixosModule ];
  home-manager.useGlobalPkgs = true;
  home-manager.users.user = { pkgs, ... }: {
    home.username = "user";
    home.homeDirectory = "/home/user";
    home.packages = [ pkgs.httpie ];
    home.stateVersion = "22.11";
    xdg = { userDirs = { enable = true; }; };
    home.file.".icons/default/index.theme".text = ''
      [icon theme]
      Inherits=phinger-cursors
    '';
    xresources.properties = {
      "Xft.hinting" = true;
      "Xft.antialias" = true;
      "Xft.autohint" = false;
      "Xft.lcdfilter" = "lcddefault";
      "Xft.hintstyle" = "hintfull";
      "Xft.rgba" = "rgb";
    };
    xdg.configFile."xfce4/helpers.rc".text = ''
      TerminalEmulator=kitty
      TerminalEmulatorDismissed=true
    '';
    xdg.configFile."mozc/ibus_config.textproto".text = ''
      engines {
        name : "mozc-jp"
        longname : "Mozc"
        layout : "default"
        layout_variant : ""
        layout_option : ""
        rank : 80
      }
      active_on_launch: True
    '';
    xdg.configFile."ranger/rc.conf".text = ''
      set line_numbers absolute
      set padding_right false
      set vcs_aware true
      set show_hidden true
      set confirm_on_delete always
      set save_console_history false
      set mouse_enabled false
      set tilde_in_titlebar true

      alias r rename
      alias d delete

      map DD shell trash %s

      set use_preview_script true
      set preview_files true
      set preview_images true
      set preview_images_method kitty
    '';
    xdg.configFile."fish/config.fish".text = ''
      set -U fish_greeting ""

      export PATH="$HOME/.deno/bin:$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.local/bin:$HOME/.go/bin:$PATH"
      export GOPATH="$HOME/.go"
      export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
      export TERMCMD="kitty --single-instance"

      # Required to make gpg-agent work in cases like git commit
      export GPG_TTY=(tty)

      # Add color to man pages
      set -x -U LESS_TERMCAP_md (printf "\e[01;31m")
      set -x -U LESS_TERMCAP_me (printf "\e[0m")
      set -x -U LESS_TERMCAP_se (printf "\e[0m")
      set -x -U LESS_TERMCAP_so (printf "\e[01;44;30m")
      set -x -U LESS_TERMCAP_ue (printf "\e[0m")
      set -x -U LESS_TERMCAP_us (printf "\e[01;32m")

      # Always use the default keybindings in fish
      fish_default_key_bindings

      # Convert unnecessarily large wav files to flac
      function wav2flac
          set ORIGINAL_SIZE (du -hs | cut -f1)

          fd -e wav -x ffmpeg -i "{}" -loglevel quiet -stats "{.}.flac"
          fd -e wav -X trash

          set NEW_SIZE (du -hs | cut -f1)

          echo "Done. Reduced file size from $ORIGINAL_SIZE to $NEW_SIZE"
      end

      # Convert wav/flac to opus
      function opus
          set ORIGINAL_SIZE (du -hs | cut -f1)

          fd -e wav -e flac -x ffmpeg -i "{}" -c:a libopus -b:a 128K -loglevel quiet -stats "{.}.opus"
          fd -e wav -e flac -X rm -I

          set NEW_SIZE (du -hs | cut -f1)

          echo "Done. Reduced file size from $ORIGINAL_SIZE to $NEW_SIZE"
      end

      # Always use kitty ssh since it's our default terminal
      if string match -qe -- "/dev/pts/" (tty)
          alias ssh="kitty +kitten ssh"
      end

      # if status is-login
      #     if test -z "$DISPLAY" -a "$XDG_VTNR" = 1
      #         exec Hyprland
      #     end
      # end
    '';
    gtk = {
      enable = true;
      cursorTheme = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors";
      };
      gtk3.extraConfig = {
        gtk-decoration-layout = "menu:";
        gtk-xft-antialias = 1;
        gtk-xft-hinting = 1;
        gtk-xft-hintstyle = "hintfull";
        gtk-xft-rgba = "rgb";
        gtk-recent-files-enabled = false;
      };
      iconTheme = {
        package = pkgs.fluent-icon-theme;
        name = "Fluent";
      };
    };
    programs.kitty = {
      enable = true;
      settings = {
        enable_audio_bell = false;
        allow_remote_control = true;
        dynamic_background_opacity = true;
        background_opacity = "0.95";
        close_on_child_death = true;
        cursor_blink_interval = 0;
        wayland_titlebar_color = "background";
        listen_on = "unix:/tmp/kitty";
        open_url_with = "librewolf";
        window_padding_width = 5;
        tab_bar_margin_width = 5;
      };
    };
    xdg.configFile."kitty/diff.conf".text = ''
      map d scroll_to next-page
      map u scroll_to prev-page
      map g scroll_to start
      map G scroll_to end
    '';
    programs.bat = { enable = true; };
    programs.swaylock = {
      package = pkgs."swaylock-effects";
      settings = {
        show-keyboard-layout = true;
        daemonize = true;
        effect-blur = "5x2";
        clock = true;
        indicator = true;
        font-size = 25;
        indicator-radius = 85;
        indicator-thickness = 16;
        screenshots = true;
        fade-in = 1;
      };
    };
    services.dunst = {
      enable = true;
      settings = {
        global = {
          geometry = "1870x5-25+45";
          width = 350;
          separator_height = 5;
          padding = 24;
          horizontal_padding = 24;
          frame_width = 3;
          idle_threshold = 120;
          alignment = "center";
          word_wrap = "yes";
          transparency = 5;
          format = "<b>%s</b>: %b";
          markup = "full";
          min_icon_size = 128;
          max_icon_size = 128;
        };
      };
    };
    programs.waybar = {
      enable = true;
      package = hyprland.packages."x86_64-linux".waybar-hyprland;
      settings = {
        mainBar = {
          layer = "bottom";
          position = "top";
          height = 30;
          modules-left = [ "hyprland/window" ];
          modules-center = [ "wlr/workspaces" ];
          modules-right =
            [ "tray" "wireplumber" "backlight" "battery" "clock" ];
        };
      };
    };
    programs.zathura = {
      enable = true;
      options = {
        guioptions = "v";
        adjust-open = "width";
        statusbar-basename = true;
        render-loading = false;
        scroll-step = 120;
      };
    };
    programs.feh = {
      enable = true;
      keybindings = {
        toggle_actions = null;
        toggle_aliasing = null;
        toggle_caption = null;
        toggle_filenames = "d";
        toggle_exif = null;
        save_filelist = null;
        toggle_fixed_geometry = "g";
        toggle_pause = "h";
        toggle_info = null;
        toggle_keep_vp = null;
        toggle_menu = null;
        next_img = [ "k" "Right" ];
        toggle_pointer = "a";
        prev_img = [ "j" "Left" ];
        quit = "q";
        reload_image = null;
        save_image = null;
        toggle_fullscreen = "f";
        size_to_image = "w";
        close = null;
        jump_random = "z";
        prev_dir = null;
        next_dir = null;
        orient_3 = null;
        orient_1 = null;
        flip = null;
        mirror = null;
        action_0 = null;
        action_1 = null;
        action_2 = null;
        action_3 = null;
        action_4 = null;
        action_5 = null;
        action_6 = null;
        action_7 = null;
        action_8 = null;
        action_9 = null;
        jump_first = "J";
        jump_last = "K";
        jump_fwd = "H";
        jump_back = "L";
        reload_plus = null;
        reload_minus = null;
        remove = null;
        delete = null;
        scroll_left = "b";
        scroll_right = "n";
        scroll_up = [ "u" "Up" ];
        scroll_down = [ "d" "Down" ];
        scroll_left_page = null;
        scroll_right_page = null;
        scroll_up_page = null;
        scroll_down_page = null;
        render = null;
        zoom_in = "h";
        zoom_out = "l";
        zoom_default = "o";
        zoom_fit = null;
        zoom_fill = "p";
        menu_close = null;
        menu_up = null;
        menu_down = null;
        menu_parent = null;
        menu_child = null;
        menu_select = null;
        toggle_auto_zoom = "m";
      };
    };
    services.mpd = {
      enable = true;
      extraConfig = ''
        auto_update "yes"
      '';
    };
    programs.ncmpcpp = {
      enable = true;
      bindings = [
        { key = "mouse"; command = "dummy"; }
        { key = "h"; command = ["previous_column" "jump_to_parent_directory"]; }
        { key = "j"; command = "scroll_down"; }
        { key = "k"; command = "scroll_up"; }
        { key = "l"; command = [ "next_column" "enter_directory" "play_item"]; }
        { key = "H"; command = [ "select_item" "scroll_down"]; }
        { key = "J"; command = ["move_sort_order_down" "move_selected_items_down"]; }
        { key = "K"; command = ["move_sort_order_up" "move_selected_items_up"]; }
        { key = "L"; command = [ "select_item" "scroll_up"]; }
        { key = "'"; command = "remove_selection"; }
        { key = "ctrl-u"; command = "page_up"; }
        { key = "ctrl-d"; command = "page_down"; }
        { key = "u"; command = "page_up"; }
        { key = "d"; command = "page_down"; }
        { key = "n"; command = "next_found_item"; }
        { key = "N"; command = "previous_found_item"; }
        { key = "t"; command = "next_screen"; }
        { key = "g"; command = "move_home"; }
        { key = "G"; command = "move_end"; }
        { key = "w"; command = "next"; }
        { key = "b"; command = "previous"; }
        { key = ";"; command = "seek_forward"; }
        { key = ","; command = "seek_backward"; }
        { key = "f"; command = "apply_filter"; }
        { key = "i"; command = "select_item"; }
        { key = "x"; command = [ "delete_playlist_items" "delete_browser_items" "delete_stored_playlist" ]; }
        { key = "U"; command = "update_database"; }
        { key = "m"; command = "add_random_items"; }
      ];
      settings = {
        ncmpcpp_directory = "~/.config/ncmpcpp";
        user_interface = "alternative";
        autocenter_mode = "yes";
        allow_for_physical_item_deletion = "no";
        mouse_support = "no";
        execute_on_song_change = "~/.config/mpd/mpdnotify";
        mpd_crossfade_time = 3;
      };
    };
    programs.lf = {
      enable = true;
    };
    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "curses";
      defaultCacheTtl = 43200;
      maxCacheTtl = 43200;
    };
    programs.gpg = {
      enable = true;
      # homedir = "${config.xdg.dataHome}/gnupg"
      settings = {
        personal-digest-preferences = "SHA512";
        cert-digest-algo = "SHA512";
        cipher-algo = "AES256";
        default-preference-list = "SHA512 SHA384 SHA256 SHA224 AES256 AES192 AES CAST5 ZLIB BZIP2 ZIP Uncompressed";
        personal-cipher-preferences = "TWOFISH CAMELLIA256 AES 3DES";
        throw-keyids = true;
        keyid-format = "0xlong";
        with-fingerprint = true;
      };
    };
    programs.neovim = {
      enable = true;
      extraConfig = ''
        filetype plugin indent on
        set undofile
        set spell
        set number
        set clipboard=unnamedplus
        set fileencoding=utf-8         " Ensure that we always save files as utf-8
        set fileencodings=utf-8,sjis   " Automatically open shiftjis files with their proper encoding
        set spelllang=en_us,cjk        " Don't show errors for CJK characters
        set noshowmode                 " Disable the --MODE-- text (enable if not using the status line)
        set mouse=a
        set ignorecase                 " By default use case-insensitive search (combine with smartcase)
        set smartcase                  " Make search case-sensitive when using capital letters
        set scrolloff=1                " The minimal number of rows to show when scrolling up/down
        set sidescrolloff=5            " The minimal number of columns to show when scrolling left/right
        set tabstop=4                  " Show a tab character as 4 spaces
        set softtabstop=0              " Edit soft tabs as if they're regular spaces
        set shiftwidth=4               " Make autoindent appear as 4 spaces


        map <MiddleMouse> <Nop>
        imap <MiddleMouse> <Nop>
        map <2-MiddleMouse> <Nop>
        imap <2-MiddleMouse> <Nop>
        map <3-MiddleMouse> <Nop>
        imap <3-MiddleMouse> <Nop>
        map <4-MiddleMouse> <Nop>
        imap <4-MiddleMouse> <Nop>

        highlight Search ctermbg=240 ctermfg=255
        highlight IncSearch ctermbg=255 ctermfg=240

        let mapleader = ' '
        nnoremap <silent> <leader>e :set nu!<CR>
        nnoremap <silent> <leader>t :OverCommandLine<CR>%s/
        nnoremap <silent> <leader>a :Vexplore<CR>
        nnoremap <silent> <leader>s :Sexplore<CR>
        nnoremap <silent> <leader>d :Explore<CR>
        nnoremap <silent> <leader>f :Files<CR>
        nnoremap <silent> <leader>g :set hlsearch!<CR>
        nnoremap <silent> <leader>j :Buffers<CR>
        nnoremap <silent> <leader>k :NERDTreeToggleVCS<CR>
        nnoremap <silent> <leader>l :Rg<CR>
        nnoremap <silent> <leader>; <C-w>w
        vnoremap <C-s> y:silent !notify-send -t 4000 "成果" "$(tango '<C-r>0')"<CR>:<Esc>

        autocmd BufNewFile,BufRead *.ecr    setlocal syntax=html
        autocmd BufWritePre,FileWritePre * silent! call mkdir(expand('<afile>:p:h'), 'p')

      '';
      plugins = with pkgs.vimPlugins; [
        {
          plugin = nvim-tree-lua;
          type = "lua";
          config = ''
            require("nvim-tree").setup()
          '';
        }
        {
          plugin = indent-blankline-nvim;
          type = "lua";
          config = ''
            require("indent_blankline").setup()
          '';
        }
        {
          plugin = barbar-nvim;
          type = "lua";
          config = ''
            vim.g.barbar_auto_setup = false
            require'barbar'.setup {
              auto_hide = true,
              sidebar_filetypes = {
                NvimTree = true,
              },
            }
          '';
        }
        {
          plugin = gitsigns-nvim;
          type = "lua";
          config = ''
            require('gitsigns').setup()
          '';
        }
        {
          plugin = nvim-web-devicons;
          type = "lua";
        }
        {
          plugin = nvim-scrollbar;
          type = "lua";
          config = ''require("scrollbar").setup()'';
        }
        {
          plugin = nvim-base16;
          type = "lua";
          config = "vim.cmd('colorscheme base16-monokai')";
        }
        {
          plugin = lualine-nvim;
          type = "lua";
          config = "require('lualine').setup()";
        }
        {
          plugin = nvim-cursorline;
          type = "lua";
          config = ''
            require('nvim-cursorline').setup {
              cursorline = {
                enable = false,
              },
              cursorword = {
                enable = true,
                min_length = 3,
                hl = { underline = true },
              }
            }
          '';
        }
        {
          plugin = comment-nvim;
          type = "lua";
          config = ''require('Comment').setup()'';
        }
        {
          plugin = plenary-nvim;
          type = "lua";
        }
        {
          plugin = telescope-nvim;
          type = "lua";
        }
        {
          plugin = clipboard-image-nvim;
          type = "lua";
        }
        {
          plugin = vimtex;
          config = ''
            " Disable all keybinds so we can define our own
            let g:vimtex_mappings_enabled = 0
            let g:vimtex_imaps_enabled = 0
            let g:vimtex_view_method = 'zathura'
            let g:vimtex_compiler_latexmk = {'build_dir': '.tex'}

            " Set the normal keybinds
            nnoremap <localleader>f <plug>(vimtex-view)
            nnoremap <localleader>g <plug>(vimtex-compile)
            nnoremap <localleader>d <plug>(vimtex-env-delete)
            nnoremap <localleader>c <plug>(vimtex-env-change)
          '';
        }
        vim-caddyfile
        vim-graphql
        vim-pug
        vim-prisma
        vim-javascript
        vim-jsx-pretty
        vim-vue
        vim-over
        vim-endwise
        rust-vim
      ];
    };
    editorconfig = {
      enable = true;
      settings = {
        "*" = {
          charset = "utf-8";
          end_of_line = "lf";
          insert_final_newline = true;
          indent_size = 2;
          indent_style = "space";
          trim_trailing_whitespace = true;
        };
        "*.md" = { indent_style = "tab"; };
        "Makefile" = {
          indent_style = "tab";
          indent_size = 4;
        };
        "*.html" = {
          indent_style = "tab";
          indent_size = 4;
        };
        "*.go" = {
          indent_style = "tab";
          indent_size = 4;
        };
      };
    };
    xdg.configFile."tig/config".text = ''
      color cursor black green bold
      color title-focus black blue bold
      color title-blur black blue bold
    '';
    programs.mpv = {
      enable = true;
      config = {
        screenshot-format = "png";
        profile = "gpu-hq";
        scale = "ewa_lanczossharp";
        cscale = "ewa_lanczossharp";
        video-sync = "display-resample";
        interpolation = true;
        tscale = "oversample";
        sub-auto = "fuzzy";
        sub-font = "Noto Sans CJK JP Medium";
        sub-blur = 10;
        sub-file-paths = "subs:subtitles:字幕";
        fullscreen = "yes";
        title = "\${filename} - mpv";
        script-opts =
          "osc-title=\${filename},osc-boxalpha=150,osc-showfullscreen=no,osc-boxvideo=yes";
        osc = "no";
        osd-on-seek = "no";
        osd-bar = "no";
        osd-bar-w = 30;
        osd-bar-h = "0.2";
        osd-duration = 750;
        really-quiet = "yes";
      };
      scripts = [ pkgs.mpvScripts.thumbnail ];
    };
    programs.librewolf = {
      enable = true;
      settings = {
        "middlemouse.paste" = false;
        "browser.download.useDownloadDir" = true;
        "ui.use_activity_cursor" = true;
        "browser.tabs.insertAfterCurrent" = true;
      };
    };
    programs.chromium = {
      enable = true;
      package = pkgs."ungoogled-chromium";
      commandLineArgs = [ "--ozone-platform-hint=auto" ];
      extensions = [{ id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; }];
    };
    programs.git = {
      enable = true;
      extraConfig = {
        include = { path = "~/.gituser"; };
        commit = { gpgsign = true; };
        core = {
          editor = "nvim";
          autocrlf = false;
          quotePath = false;
        };
        web = { browser = "librewolf"; };
        push = { default = "simple"; };
        branch = { autosetuprebase = "always"; };
        init = { defaultBranch = "master"; };
        rerere = { enabled = true; };
        color = { ui = true; };
        alias = {
          contrib = "shortlog -n -s";
          remotes = "remote -v";
          praise = "blame";
          verify = "log --show-signature";
        };
        "color \"diff-highlight\"" = {
          oldNormal = "red bold";
          oldHighlight = "red bold";
          newNormal = "green bold";
          newHighlight = "green bold";
        };
        "color \"diff\"" = {
          meta = "yellow";
          frag = "magenta bold";
          commit = "yellow bold";
          old = "red bold";
          new = "green bold";
          whitespace = "red reverse";
        };
      };
      diff-so-fancy = { enable = true; };
    };
    services.udiskie.enable = true;
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

        # Use spellcheck
        c.spellcheck.languages = ["en-US"]

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
  };
}
