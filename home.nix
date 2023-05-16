{ config, lib, nixpkgs, pkgs, home-manager, hyprland, ... }: {
  imports = [ home-manager.nixosModule ];
  home-manager.useGlobalPkgs = true;
  home-manager.sharedModules = [{
    xdg.configFile."hypr/hyprland.conf".text = ''
      env=XCURSOR_SIZE,24
      env=BROWSER,librewolf
      env=GTK_IM_MODULE,fcitx
      env=QT_IM_MODULE,fcitx
      env=XMODIFIERS,@im=fcitx
      env=SDL_IM_MODULE,fcitx
      env=GLFW_IM_MODULE,ibus
      monitor=,preferred,auto,1

      exec-once = swaybg --mode fill --image "$(fd -d 1 wallpaper.png /nix/store/)"
      exec-once = wpctl set-volume @DEFAULT_AUDIO_SINK@ 20%
      exec-once = sleep 0.5 && waybar
      exec-once = fcitx5                          # Japanese input support
      exec-once = mullvad-vpn
      exec-once = wl-paste -p --watch wl-copy -pc # Disable middle click paste

      input {
        kb_layout = us
        accel_profile = flat
        follow_mouse = 1
        mouse_refocus = 0
        sensitivity = 0
        touchpad {
          natural_scroll = yes
          disable_while_typing = no
        }
      }

      general {
        gaps_in = 0
        gaps_out = 0
        border_size = 1
        col.active_border = rgba(f4bf75ee) rgba(fd971fee) 45deg
        col.inactive_border = rgba(49483eaa)
        layout = master
        resize_on_border = yes
      }

      decoration {
        rounding = 0
        blur = yes
        blur_size = 3
        blur_passes = 1
        blur_new_optimizations = yes
        drop_shadow = yes
        shadow_range = 4
        shadow_render_power = 3
        col.shadow = rgba(1a1a1aee)
      }

      animations {
        enabled = yes
        bezier = myBezier, 0.05, 0.9, 0.1, 1.05
        animation = windows, 1, 7, myBezier
        animation = windowsOut, 1, 7, default, popin 80%
        animation = border, 1, 10, default
        animation = borderangle, 1, 8, default
        animation = fade, 1, 7, default
        animation = workspaces, 1, 6, default, slidevert
        animation = specialWorkspace, 1, 6, default, fade
      }

      dwindle {
        preserve_split = yes
        no_gaps_when_only = yes
        special_scale_factor = 0.95
      }

      master {
        new_is_master = yes
        new_on_top = yes
        mfact = 0.65
        special_scale_factor = 0.95
        no_gaps_when_only = yes
        allow_small_split = yes
      }

      gestures {
        workspace_swipe = yes
      }

      device:synps/2-synaptics-touchpad {
        sensitivity = 0.75
        accel_profile = flat
        natural_scroll = yes
        disable_while_typing = no
      }

      device:tpps/2-elan-trackpoint {
        sensitivity = 0.5
        accel_profile = flat
      }

      binds {
        workspace_back_and_forth = yes
        allow_workspace_cycles = yes
      }

      bind = SUPER_SHIFT, Return, exec, kitty
      bind = SUPER, Q, killactive,
      bind = SUPER, P, exec, grim -g "$(slurp)"
      bind = , Print, exec, grim && dunstify Screenshot Captured.
      bind = SUPER_ALT, delete, exit
      bind = SUPER, V, togglefloating,
      bind = SUPER, V, centerwindow,
      bind = SUPER, O, exec, killall -SIGUSR1 .waybar-wrapped
      bind = SUPER, X, pin
      bind = SUPER, F, fullscreen, 1
      bind = SUPER_SHIFT, F, fullscreen
      bind = SUPER, bracketright, changegroupactive, f
      bind = SUPER, bracketleft, changegroupactive, b
      bind = SUPER, S, togglespecialworkspace
      bind = SUPER_SHIFT, S, movetoworkspace, special
      bind = SUPER_SHIFT, S, togglespecialworkspace
      bind = SUPER, Z, exec, rofi -show drun

      bind = SUPER, Return, exec, ~/.config/hypr/swapmaster.sh
      bind = SUPER, J, layoutmsg, cyclenext
      bind = SUPER, K, layoutmsg, cycleprev
      bind = SUPER_SHIFT, J, layoutmsg, swapnext
      bind = SUPER_SHIFT, K, layoutmsg, swapprev
      bind = SUPER, C, layoutmsg, orientationcenter
      bind = SUPER, H, layoutmsg, addmaster
      bind = SUPER, L, layoutmsg, removemaster
      bind = SUPER_SHIFT, H, splitratio, -0.05
      bind = SUPER_SHIFT, L, splitratio, +0.05

      bind = SUPER, grave, workspace, previous
      bind = SUPER, 1, workspace, 1
      bind = SUPER, 2, workspace, 2
      bind = SUPER, 3, workspace, 3
      bind = SUPER, 4, workspace, 4
      bind = SUPER, 5, workspace, 5
      bind = SUPER, 6, workspace, 6
      bind = SUPER, 7, workspace, 7
      bind = SUPER, 8, workspace, 8
      bind = SUPER, 9, workspace, 9
      bind = SUPER, 0, workspace, 10
      bind = SUPER_SHIFT, 1, movetoworkspace, 1
      bind = SUPER_SHIFT, 2, movetoworkspace, 2
      bind = SUPER_SHIFT, 3, movetoworkspace, 3
      bind = SUPER_SHIFT, 4, movetoworkspace, 4
      bind = SUPER_SHIFT, 5, movetoworkspace, 5
      bind = SUPER_SHIFT, 6, movetoworkspace, 6
      bind = SUPER_SHIFT, 7, movetoworkspace, 7
      bind = SUPER_SHIFT, 8, movetoworkspace, 8
      bind = SUPER_SHIFT, 9, movetoworkspace, 9
      bind = SUPER_SHIFT, 0, movetoworkspace, 10
      bind = SUPER_CTRL, 1, exec, ~/.config/hypr/tags.sh 1
      bind = SUPER_CTRL, 2, exec, ~/.config/hypr/tags.sh 2
      bind = SUPER_CTRL, 3, exec, ~/.config/hypr/tags.sh 3
      bind = SUPER_CTRL, 4, exec, ~/.config/hypr/tags.sh 4
      bind = SUPER_CTRL, 5, exec, ~/.config/hypr/tags.sh 5
      bind = SUPER_CTRL, 6, exec, ~/.config/hypr/tags.sh 6
      bind = SUPER_CTRL, 7, exec, ~/.config/hypr/tags.sh 7
      bind = SUPER_CTRL, 8, exec, ~/.config/hypr/tags.sh 8
      bind = SUPER_CTRL, 9, exec, ~/.config/hypr/tags.sh 9
      bind = SUPER_CTRL, 0, exec, ~/.config/hypr/tags.sh 10

      layerrule = blur,waybar
      layerrule = blur,rofi

      # Scroll through existing workspaces with super + scroll
      bind = SUPER, mouse_down, workspace, e+1
      bind = SUPER, mouse_up, workspace, e-1

      # Move/resize windows with super + LMB/RMB and dragging
      bindm = SUPER, mouse:272, movewindow
      bindm = SUPER, mouse:273, resizewindow

      # Change volume with keys
      # TODO: Change notification once at 0/100%
      bindl=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle && notify-send -t 2000 "Muted" "$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
      bindl=, XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+ && notify-send -t 2000 "Raised volume to" "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | tail -c 3)%"
      bindl=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- && notify-send -t 2000 "Lowered volume to" "$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | tail -c 3)%"
      bindl=, XF86MonBrightnessDown, exec, brightnessctl set 5%- && notify-send -t 2000 "Decreased brightness to" "$(brightnessctl get)"
      bindl=, XF86MonBrightnessUp, exec, brightnessctl set +5% && notify-send -t 2000 "Increased brightness to" "$(brightnessctl get)"

      misc {
        disable_hyprland_logo = yes
        animate_mouse_windowdragging = yes
        focus_on_activate = yes
      }
    '';
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
    xdg.configFile."mozc/ibus_config.textproto".force = true;
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
    programs.bat = { enable = true; };
    services.mpd = {
      enable = true;
      extraConfig = ''
        auto_update "yes"
      '';
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
        nnoremap <silent> <leader>a :NvimTreeToggle<CR>
        nnoremap <silent> <leader>f :Files<CR>
        nnoremap <silent> <leader>g :set hlsearch!<CR>
        nnoremap <silent> <leader>j :BufferPrevious<CR>
        nnoremap <silent> <leader>k :BufferNext<CR>
        nnoremap <silent> <leader>x :BufferClose<CR>
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
          plugin = comment-nvim;
          type = "lua";
          config = ''require('Comment').setup()'';
        }
        {
          plugin = plenary-nvim;
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
        fzf-vim
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
    services.udiskie.enable = true;
    xdg.configFile."hypr/swapmaster.sh".source = ./swapmaster.sh;
    xdg.configFile."hypr/tags.sh".source = ./tags.sh;
    xdg = { userDirs = { enable = true; }; };
    home.stateVersion = "22.11";
  }];
}
