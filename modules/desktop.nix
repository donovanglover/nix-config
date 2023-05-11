{ config, lib, nixpkgs, home-manager, hyprland, ... }: {
  imports = [ home-manager.nixosModule ];
  home-manager.users.user = { pkgs, ... }: {
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
  };
}
