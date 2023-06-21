{
  programs.joshuto = {
    enable = true;

    settings = {
      display = {
        automatically_count_files = true;
        show_borders = false;
        show_hidden = true;
        show_icons = true;
        line_number_style = "absolute";
        collapse_preview = false;
      };

      preview = {
        max_preview_size = 10000000000;
        preview_script = "~/.config/joshuto/preview.sh";
        preview_shown_hook_script = "~/.config/joshuto/kitty-show.sh";
        preview_removed_hook_script = "~/.config/joshuto/kitty-remove.sh";
      };
    };

    mimetype = {
      class = {
        audio_default = [
          { command = "mpv"; args = [ "--" ]; }
          { command = "mediainfo"; confirm_exit = true; }
        ];

        image_default = [
          { command = "feh"; args = [ "--" ]; fork = true; silent = true; }
        ];

        video_default = [
          { command = "mpv"; args = [ "--" ]; fork = true; silent = true; }
          { command = "mediainfo"; confirm_exit = true; }
          { command = "mpv"; args = [ "--mute" "on" "--" ]; fork = true; silent = true; }
        ];

        text_default = [
          { command = "nvim"; }
        ];

        reader_default = [
          { command = "zathura"; fork = true; silent = true; }
        ];

        libreoffice_default = [
          { command = "libreoffice"; fork = true; silent = true; }
        ];
      };

      extension = {
        ## image formats
        avif."inherit" = "image_default";
        bmp."inherit" = "image_default";
        gif."inherit" = "image_default";
        heic."inherit" = "image_default";
        jpeg."inherit" = "image_default";
        jpe."inherit" = "image_default";
        jpg."inherit" = "image_default";
        pgm."inherit" = "image_default";
        png."inherit" = "image_default";
        ppm."inherit" = "image_default";
        webp."inherit" = "image_default";

        ## audio formats
        flac."inherit" = "audio_default";
        m4a."inherit" = "audio_default";
        mp3."inherit" = "audio_default";
        ogg."inherit" = "audio_default";
        wav."inherit" = "audio_default";

        ## video formats
        avi."inherit" = "video_default";
        av1."inherit" = "video_default";
        flv."inherit" = "video_default";
        mkv."inherit" = "video_default";
        m4v."inherit" = "video_default";
        mov."inherit" = "video_default";
        mp4."inherit" = "video_default";
        ts."inherit" = "video_default";
        webm."inherit" = "video_default";
        wmv."inherit" = "video_default";

        ## text formats
        build."inherit" = "text_default";
        c."inherit" = "text_default";
        cmake."inherit" = "text_default";
        conf."inherit" = "text_default";
        cpp."inherit" = "text_default";
        css."inherit" = "text_default";
        csv."inherit" = "text_default";
        cu."inherit" = "text_default";
        ebuild."inherit" = "text_default";
        eex."inherit" = "text_default";
        env."inherit" = "text_default";
        ex."inherit" = "text_default";
        exs."inherit" = "text_default";
        go."inherit" = "text_default";
        h."inherit" = "text_default";
        hpp."inherit" = "text_default";
        hs."inherit" = "text_default";
        html."inherit" = "text_default";
        ini."inherit" = "text_default";
        java."inherit" = "text_default";
        js."inherit" = "text_default";
        json."inherit" = "text_default";
        kt."inherit" = "text_default";
        lock."inherit" = "text_default";
        lua."inherit" = "text_default";
        log."inherit" = "text_default";
        md."inherit" = "text_default";
        micro."inherit" = "text_default";
        ninja."inherit" = "text_default";
        py."inherit" = "text_default";
        rkt."inherit" = "text_default";
        rs."inherit" = "text_default";
        scss."inherit" = "text_default";
        sh."inherit" = "text_default";
        srt."inherit" = "text_default";
        svelte."inherit" = "text_default";
        toml."inherit" = "text_default";
        tsx."inherit" = "text_default";
        txt."inherit" = "text_default";
        vim."inherit" = "text_default";
        xml."inherit" = "text_default";
        yaml."inherit" = "text_default";
        yml."inherit" = "text_default";

        # archive formats
        "7z".app_list = [{ command = "7z"; args = [ "x" ]; confirm_exit = true; }];
        rar.app_list = [
          { command = "unrar"; args = [ "x" ]; confirm_exit = true; }
          { command = "file-roller"; fork = true; silent = true; }
        ];
        zip.app_list = [
          { command = "unzip"; confirm_exit = true; }
          { command = "file-roller"; fork = true; silent = true; }
        ];

        # misc formats
        aup.app_list = [
          { command = "audacity"; fork = true; silent = true; }
        ];

        odt."inherit" = "libreoffice_default";
        odf."inherit" = "libreoffice_default";
        ods."inherit" = "libreoffice_default";
        odp."inherit" = "libreoffice_default";

        doc."inherit" = "libreoffice_default";
        docx."inherit" = "libreoffice_default";
        xls."inherit" = "libreoffice_default";
        xlsx."inherit" = "libreoffice_default";
        ppt."inherit" = "libreoffice_default";
        pptx."inherit" = "libreoffice_default";

        pdf."inherit" = "reader_default";

        kra.app_list = [
          { command = "krita"; fork = true; silent = true; }
        ];
        kdenlive.app_list = [
          { command = "kdenlive"; fork = true; silent = true; }
        ];

        tex.app_list = [
          { command = "micro"; }
          { command = "gedit"; fork = true; silent = true; }
          { command = "bat"; confirm_exit = true; }
          { command = "pdflatex"; }
        ];

        torrent.app_list = [
          { command = "transmission-gtk"; }
        ];
      };

      mimetype = {
        application.subtype.octet-stream."inherit" = "video_default";
        text."inherit" = "text_default";
        video."inherit" = "video_default";
      };
    };

    keymap = {
      default_view = {
        keymap = [
          { keys = [ "escape" ]; command = "escape"; }
          { keys = [ "ctrl+t" ]; command = "new_tab"; }
          { keys = [ "alt+t" ]; command = "new_tab --cursor"; }
          { keys = [ "T" ]; command = "new_tab --current"; }
          { keys = [ "W" ]; command = "close_tab"; }
          { keys = [ "ctrl+w" ]; command = "close_tab"; }
          { keys = [ "q" ]; command = "close_tab"; }
          { keys = [ "ctrl+c" ]; command = "quit"; }
          { keys = [ "o" ]; command = "quit --output-selected-files"; }

          { keys = [ "R" ]; command = "reload_dirlist"; }
          { keys = [ "z" "h" ]; command = "toggle_hidden"; }
          { keys = [ "ctrl+h" ]; command = "toggle_hidden"; }
          { keys = [ "\t" ]; command = "tab_switch 1"; }
          { keys = [ "backtab" ]; command = "tab_switch -1"; }

          { keys = [ "alt+1" ]; command = "tab_switch_index 1"; }
          { keys = [ "alt+2" ]; command = "tab_switch_index 2"; }
          { keys = [ "alt+3" ]; command = "tab_switch_index 3"; }
          { keys = [ "alt+4" ]; command = "tab_switch_index 4"; }
          { keys = [ "alt+5" ]; command = "tab_switch_index 5"; }

          { keys = [ "1" ]; command = "numbered_command 1"; }
          { keys = [ "2" ]; command = "numbered_command 2"; }
          { keys = [ "3" ]; command = "numbered_command 3"; }
          { keys = [ "4" ]; command = "numbered_command 4"; }
          { keys = [ "5" ]; command = "numbered_command 5"; }
          { keys = [ "6" ]; command = "numbered_command 6"; }
          { keys = [ "7" ]; command = "numbered_command 7"; }
          { keys = [ "8" ]; command = "numbered_command 8"; }
          { keys = [ "9" ]; command = "numbered_command 9"; }

          # arrow keys
          { keys = [ "arrow_up" ]; command = "cursor_move_up"; }
          { keys = [ "arrow_down" ]; command = "cursor_move_down"; }
          { keys = [ "arrow_left" ]; command = "cd .."; }
          { keys = [ "arrow_right" ]; command = "open"; }
          { keys = [ "\n" ]; command = "open"; }
          { keys = [ "home" ]; command = "cursor_move_home"; }
          { keys = [ "end" ]; command = "cursor_move_end"; }
          { keys = [ "page_up" ]; command = "cursor_move_page_up"; }
          { keys = [ "page_down" ]; command = "cursor_move_page_down"; }
          { keys = [ "ctrl+u" ]; command = "cursor_move_page_up 0.5"; }
          { keys = [ "ctrl+d" ]; command = "cursor_move_page_down 0.5"; }

          # vim-like keybindings
          { keys = [ "j" ]; command = "cursor_move_down"; }
          { keys = [ "k" ]; command = "cursor_move_up"; }
          { keys = [ "h" ]; command = "cd .."; }
          { keys = [ "l" ]; command = "open"; }
          { keys = [ "g" "g" ]; command = "cursor_move_home"; }
          { keys = [ "G" ]; command = "cursor_move_end"; }
          { keys = [ "r" ]; command = "open_with"; }

          { keys = [ "H" ]; command = "cursor_move_page_home"; }
          { keys = [ "L" ]; command = "cursor_move_page_middle"; }
          { keys = [ "M" ]; command = "cursor_move_page_end"; }

          { keys = [ "[" ]; command = "parent_cursor_move_up"; }
          { keys = [ "]" ]; command = "parent_cursor_move_down"; }

          { keys = [ "c" "d" ]; command = ":cd "; }
          { keys = [ "d" "d" ]; command = "cut_files"; }
          { keys = [ "y" "y" ]; command = "copy_files"; }
          { keys = [ "y" "n" ]; command = "copy_filename"; }
          { keys = [ "y" "." ]; command = "copy_filename_without_extension"; }
          { keys = [ "y" "p" ]; command = "copy_filepath"; }
          { keys = [ "y" "d" ]; command = "copy_dirpath"; }

          { keys = [ "p" "l" ]; command = "symlink_files --relative=false"; }
          { keys = [ "p" "L" ]; command = "symlink_files --relative=true"; }

          { keys = [ "delete" ]; command = "delete_files"; }
          { keys = [ "d" "D" ]; command = "delete_files"; }

          { keys = [ "p" "p" ]; command = "paste_files"; }
          { keys = [ "p" "o" ]; command = "paste_files --overwrite=true"; }

          { keys = [ "a" ]; command = "rename_append"; }
          { keys = [ "A" ]; command = "rename_prepend"; }

          { keys = [ "f" "t" ]; command = ":touch "; }

          { keys = [ " " ]; command = "select --toggle=true"; }
          { keys = [ "t" ]; command = "select --all=true --toggle=true"; }
          { keys = [ "V" ]; command = "toggle_visual"; }

          { keys = [ "w" ]; command = "show_tasks --exit-key=w"; }
          { keys = [ "b" "b" ]; command = "bulk_rename"; }
          { keys = [ "=" ]; command = "set_mode"; }

          { keys = [ ":" ]; command = ":"; }
          { keys = [ ";" ]; command = ":"; }

          { keys = [ "'" ]; command = ":shell "; }
          { keys = [ "m" "k" ]; command = ":mkdir "; }
          { keys = [ "c" "w" ]; command = ":rename "; }

          { keys = [ "/" ]; command = ":search "; }
          { keys = [ "|" ]; command = ":search_inc "; }
          { keys = [ "\\" ]; command = ":search_glob "; }
          { keys = [ "S" ]; command = "search_fzf"; }
          { keys = [ "C" ]; command = "subdir_fzf"; }

          { keys = [ "n" ]; command = "search_next"; }
          { keys = [ "N" ]; command = "search_prev"; }

          { keys = [ "s" "r" ]; command = "sort reverse"; }
          { keys = [ "s" "l" ]; command = "sort lexical"; }
          { keys = [ "s" "m" ]; command = "sort mtime"; }
          { keys = [ "s" "n" ]; command = "sort natural"; }
          { keys = [ "s" "s" ]; command = "sort size"; }
          { keys = [ "s" "e" ]; command = "sort ext"; }

          { keys = [ "m" "s" ]; command = "linemode size"; }
          { keys = [ "m" "m" ]; command = "linemode mtime"; }
          { keys = [ "m" "M" ]; command = "linemode sizemtime"; }

          { keys = [ "g" "r" ]; command = "cd /"; }
          { keys = [ "g" "c" ]; command = "cd ~/.config"; }
          { keys = [ "g" "d" ]; command = "cd ~/Downloads"; }
          { keys = [ "g" "e" ]; command = "cd /etc"; }
          { keys = [ "g" "h" ]; command = "cd ~/"; }
          { keys = [ "?" ]; command = "help"; }
        ];
      };

      task_view = {
        keymap = [
          # arrow keys
          { keys = [ "arrow_up" ]; command = "cursor_move_up"; }
          { keys = [ "arrow_down" ]; command = "cursor_move_down"; }
          { keys = [ "home" ]; command = "cursor_move_home"; }
          { keys = [ "end" ]; command = "cursor_move_end"; }

          # vim-like keybindings
          { keys = [ "j" ]; command = "cursor_move_down"; }
          { keys = [ "k" ]; command = "cursor_move_up"; }
          { keys = [ "g" "g" ]; command = "cursor_move_home"; }
          { keys = [ "G" ]; command = "cursor_move_end"; }

          { keys = [ "w" ]; command = "show_tasks"; }
          { keys = [ "escape" ]; command = "show_tasks"; }
        ];
      };

      help_view = {
        keymap = [
          # arrow keys
          { keys = [ "arrow_up" ]; command = "cursor_move_up"; }
          { keys = [ "arrow_down" ]; command = "cursor_move_down"; }
          { keys = [ "home" ]; command = "cursor_move_home"; }
          { keys = [ "end" ]; command = "cursor_move_end"; }

          # vim-like keybindings
          { keys = [ "j" ]; command = "cursor_move_down"; }
          { keys = [ "k" ]; command = "cursor_move_up"; }
          { keys = [ "g" "g" ]; command = "cursor_move_home"; }
          { keys = [ "G" ]; command = "cursor_move_end"; }

          { keys = [ "w" ]; command = "show_tasks"; }
          { keys = [ "escape" ]; command = "show_tasks"; }
        ];
      };
    };

    theme = {
      selection = {
        fg = "light_yellow";
        bold = true;
      };

      visual_mode_selection = {
        fg = "light_red";
        bold = true;
      };

      selection.prefix = {
        prefix = "  ";
        size = 2;
      };

      executable = {
        fg = "light_green";
        bold = true;
      };

      regular = {
        fg = "white";
      };

      directory = {
        fg = "light_blue";
        bold = true;
      };

      link = {
        fg = "cyan";
        bold = true;
      };

      link_invalid = {
        fg = "red";
        bold = true;
      };

      socket = {
        fg = "light_magenta";
        bold = true;
      };

      ext = {
        bmp.fg = "yellow";
        gif.fg = "yellow";
        heic.fg = "yellow";
        jpg.fg = "yellow";
        jpeg.fg = "yellow";
        pgm.fg = "yellow";
        png.fg = "yellow";
        ppm.fg = "yellow";
        svg.fg = "yellow";

        wav.fg = "magenta";
        flac.fg = "magenta";
        mp3.fg = "magenta";
        amr.fg = "magenta";

        avi.fg = "magenta";
        flv.fg = "magenta";
        m3u.fg = "magenta";
        m4a.fg = "magenta";
        m4v.fg = "magenta";
        mkv.fg = "magenta";
        mov.fg = "magenta";
        mp4.fg = "magenta";
        mpg.fg = "magenta";
        rmvb.fg = "magenta";
        webm.fg = "magenta";
        wmv.fg = "magenta";

        "7z".fg = "red";
        bz2.fg = "red";
        gz.fg = "red";
        rar.fg = "red";
        tar.fg = "red";
        tgz.fg = "red";
        xz.fg = "red";
        zip.fg = "red";
      };
    };
  };

  xdg.configFile = {
    "joshuto/preview.sh" = {
      executable = true;
      text = /* bash */ ''
        #!/usr/bin/env bash

        IFS=$'\n'
        set -o noclobber -o noglob -o nounset -o pipefail

        FILE_PATH=""
        PREVIEW_WIDTH=10
        PREVIEW_HEIGHT=10

        while [ "$#" -gt 0 ]; do
          case "$1" in
            "--path")
              shift
              FILE_PATH="$1"
              ;;
            "--preview-width")
              shift
              PREVIEW_WIDTH="$1"
              ;;
            "--preview-height")
              shift
              PREVIEW_HEIGHT="$1"
              ;;
          esac
          shift
        done

        realpath=$(realpath "$FILE_PATH")

        handle_extension() {
            case "''${FILE_EXTENSION_LOWER}" in
                lock)
                    cat "''${FILE_PATH}" && exit 0
                    exit 1;;

                rar)
                    unrar lt -p- -- "''${FILE_PATH}" && exit 0
                    exit 1;;
                7z)
                    7z l -p -- "''${FILE_PATH}" && exit 0
                    exit 1;;

                pdf)
                    pdftotext -l 10 -nopgbrk -q -- "''${FILE_PATH}" - | \
                        fmt -w "''${PREVIEW_WIDTH}" && exit 0
                    mutool draw -F txt -i -- "''${FILE_PATH}" 1-10 | \
                        fmt -w "''${PREVIEW_WIDTH}" && exit 0
                    exiftool "''${FILE_PATH}" && exit 0
                    exit 1;;

                torrent)
                    transmission-show -- "''${FILE_PATH}" && exit 0
                    exit 1;;

                json)
                    jq --color-output . "''${FILE_PATH}" && exit 0
                    ;;
            esac
        }

        handle_mime() {
          local mimetype="''${1}"

          case "''${mimetype}" in
                ## Text
                text/* | */xml)
                    bat --color=always --paging=never \
            --style=plain \
            --terminal-width="''${PREVIEW_WIDTH}" \
             "''${FILE_PATH}" && exit 0
                    cat "''${FILE_PATH}" && exit 0
                    exit 1;;

                ## Image
                image/*)
                    exit 5;;

                ## Video and audio
                video/* | audio/*)
                    echo "$realpath"
                    mediainfo "''${FILE_PATH}" && exit 0
                    exiftool "''${FILE_PATH}" && exit 0
                    exit 1;;
            esac
        }

        FILE_EXTENSION="''${FILE_PATH##*.}"
        FILE_EXTENSION_LOWER="$(printf "%s" "''${FILE_EXTENSION}" | tr '[:upper:]' '[:lower:]')"
        handle_extension
        MIMETYPE="$( file --dereference --brief --mime-type -- "''${FILE_PATH}" )"
        handle_mime "''${MIMETYPE}"

        exit 1
      '';
    };

    "joshuto/kitty-show.sh" = {
      executable = true;
      text = /* bash */ ''
        #!/usr/bin/env bash

        FILE_PATH="$1"			# Full path of the previewed file
        PREVIEW_X_COORD="$2"		# x coordinate of upper left cell of preview area
        PREVIEW_Y_COORD="$3"		# y coordinate of upper left cell of preview area
        PREVIEW_WIDTH="$4"		# Width of the preview pane (number of fitting characters)
        PREVIEW_HEIGHT="$5"		# Height of the preview pane (number of fitting characters)

        TMP_FILE="$HOME/.cache/joshuto/thumbcache.png"

        mimetype=$(file --mime-type -Lb "$FILE_PATH")

        function image {
          kitty +kitten icat \
            --transfer-mode=file \
            --clear 2>/dev/null
          kitty +kitten icat \
            --transfer-mode=file \
            --place "''${PREVIEW_WIDTH}x''${PREVIEW_HEIGHT}@''${PREVIEW_X_COORD}x''${PREVIEW_Y_COORD}" \
            "$1" 2>/dev/null
        }

        case "$mimetype" in
          image/*)
            image "''${FILE_PATH}"
            ;;
          *)
            kitty +kitten icat \
              --transfer-mode=file \
              --clear 2>/dev/null
            ;;
        esac
      '';
    };

    "joshuto/kitty-remove.sh" = {
      executable = true;
      text = /* bash */ ''
        #!/usr/bin/env bash

        kitty +kitten icat --transfer-mode=file --clear 2>/dev/null
      '';
    };
  };

  xdg.configFile."joshuto/icons.toml".text = /* toml */ ''
    # Default fallback icons
    [defaults]
    file = ""
    directory = ""

    # Directory exact match icons
    [directory_exact]
    # English
    ".git" = ""
    "Desktop" = ""
    "Documents" = ""
    "Downloads" = ""
    "Dotfiles" = ""
    "Dropbox" = ""
    "Music" = ""
    "Pictures" = ""
    "Public" = ""
    "Templates" = ""
    "Videos" = ""

    # File exact match icons
    [file_exact]
    ".bash_aliases" = ""
    ".bash_history" = ""
    ".bash_logout" = ""
    ".bash_profile" = ""
    ".bashprofile" = ""
    ".bashrc" = ""
    ".dmrc" = ""
    ".DS_Store" = ""
    ".fasd" = ""
    ".fehbg" = ""
    ".gitattributes" = ""
    ".gitconfig" = ""
    ".gitignore" = ""
    ".gitlab-ci.yml" = ""
    ".gvimrc" = ""
    ".inputrc" = ""
    ".jack-settings" = ""
    ".mime.types" = ""
    ".ncmpcpp" = ""
    ".nvidia-settings-rc" = ""
    ".pam_environment" = ""
    ".profile" = ""
    ".recently-used" = ""
    ".selected_editor" = ""
    ".vim" = ""
    ".viminfo" = ""
    ".vimrc" = ""
    ".Xauthority" = ""
    ".Xdefaults" = ""
    ".xinitrc" = ""
    ".xinputrc" = ""
    ".Xresources" = ""
    ".zshrc" = ""
    "_gvimrc" = ""
    "_vimrc" = ""
    "a.out" = ""
    "authorized_keys" = ""
    "bspwmrc" = ""
    "cmakelists.txt" = ""
    "config" = ""
    "config.ac" = ""
    "config.m4" = ""
    "config.mk" = ""
    "config.ru" = ""
    "configure" = ""
    "docker-compose.yml" = ""
    "dockerfile" = ""
    "Dockerfile" = ""
    "dropbox" = ""
    "exact-match-case-sensitive-1.txt" = "X1"
    "exact-match-case-sensitive-2" = "X2"
    "favicon.ico" = ""
    "gemfile" = ""
    "gruntfile.coffee" = ""
    "gruntfile.js" = ""
    "gruntfile.ls" = ""
    "gulpfile.coffee" = ""
    "gulpfile.js" = ""
    "gulpfile.ls" = ""
    "ini" = ""
    "known_hosts" = ""
    "ledger" = ""
    "license" = ""
    "LICENSE" = ""
    "LICENSE.md" = ""
    "LICENSE.txt" = ""
    "Makefile" = ""
    "makefile" = ""
    "Makefile.ac" = ""
    "Makefile.in" = ""
    "mimeapps.list" = ""
    "mix.lock" = ""
    "node_modules" = ""
    "package-lock.json" = ""
    "package.json" = ""
    "playlists" = ""
    "procfile" = ""
    "Rakefile" = ""
    "rakefile" = ""
    "react.jsx" = ""
    "README" = ""
    "README.markdown" = ""
    "README.md" = ""
    "README.rst" = ""
    "README.txt" = ""
    "sxhkdrc" = ""
    "user-dirs.dirs" = ""
    "webpack.config.js" = ""

    # File extension match
    [ext]
    "7z" = ""
    "a" = ""
    "ai" = ""
    "apk" = ""
    "asm" = ""
    "asp" = ""
    "aup" = ""
    "avi" = ""
    "awk" = ""
    "bash" = ""
    "bat" = ""
    "bmp" = ""
    "bz2" = ""
    "c" = ""
    "c++" = ""
    "cab" = ""
    "cbr" = ""
    "cbz" = ""
    "cc" = ""
    "class" = ""
    "clj" = ""
    "cljc" = ""
    "cljs" = ""
    "cmake" = ""
    "coffee" = ""
    "conf" = ""
    "cp" = ""
    "cpio" = ""
    "cpp" = ""
    "cs" = ""
    "csh" = ""
    "css" = ""
    "cue" = ""
    "cvs" = ""
    "cxx" = ""
    "d" = ""
    "dart" = ""
    "db" = ""
    "deb" = ""
    "diff" = ""
    "dll" = ""
    "doc" = ""
    "docx" = ""
    "dump" = ""
    "edn" = ""
    "eex" = ""
    "efi" = ""
    "ejs" = ""
    "elf" = ""
    "elm" = ""
    "epub" = ""
    "erl" = ""
    "ex" = ""
    "exe" = ""
    "exs" = ""
    "f//" = ""
    "fifo" = "|"
    "fish" = ""
    "flac" = ""
    "flv" = ""
    "fs" = ""
    "fsi" = ""
    "fsscript" = ""
    "fsx" = ""
    "gem" = ""
    "gemspec" = ""
    "gif" = ""
    "go" = ""
    "gz" = ""
    "gzip" = ""
    "h" = ""
    "haml" = ""
    "hbs" = ""
    "hh" = ""
    "hpp" = ""
    "hrl" = ""
    "hs" = ""
    "htaccess" = ""
    "htm" = ""
    "html" = ""
    "htpasswd" = ""
    "hxx" = ""
    "ico" = ""
    "img" = ""
    "ini" = ""
    "iso" = ""
    "jar" = ""
    "java" = ""
    "jl" = ""
    "jpeg" = ""
    "jpg" = ""
    "js" = ""
    "json" = ""
    "jsx" = ""
    "key" = ""
    "ksh" = ""
    "leex" = ""
    "less" = ""
    "lha" = ""
    "lhs" = ""
    "log" = ""
    "lua" = ""
    "lzh" = ""
    "lzma" = ""
    "m4a" = ""
    "m4v" = ""
    "markdown" = ""
    "md" = ""
    "mdx" = ""
    "mjs" = ""
    "mkv" = ""
    "ml" = "λ"
    "mli" = "λ"
    "mov" = ""
    "mp3" = ""
    "mp4" = ""
    "mpeg" = ""
    "mpg" = ""
    "msi" = ""
    "mustache" = ""
    "nix" = ""
    "o" = ""
    "ogg" = ""
    "pdf" = ""
    "php" = ""
    "pl" = ""
    "pm" = ""
    "png" = ""
    "pp" = ""
    "ppt" = ""
    "pptx" = ""
    "ps1" = ""
    "psb" = ""
    "psd" = ""
    "pub" = ""
    "py" = ""
    "pyc" = ""
    "pyd" = ""
    "pyo" = ""
    "r" = "ﳒ"
    "rake" = ""
    "rar" = ""
    "rb" = ""
    "rc" = ""
    "rlib" = ""
    "rmd" = ""
    "rom" = ""
    "rpm" = ""
    "rproj" = "鉶"
    "rs" = ""
    "rss" = ""
    "rtf" = ""
    "s" = ""
    "sass" = ""
    "scala" = ""
    "scss" = ""
    "sh" = ""
    "slim" = ""
    "sln" = ""
    "so" = ""
    "sql" = ""
    "styl" = ""
    "suo" = ""
    "swift" = ""
    "t" = ""
    "tar" = ""
    "tex" = "ﭨ"
    "tgz" = ""
    "toml" = ""
    "ts" = ""
    "tsx" = ""
    "twig" = ""
    "vim" = ""
    "vimrc" = ""
    "vue" = "﵂"
    "wav" = ""
    "webm" = ""
    "webmanifest" = ""
    "webp" = ""
    "xbps" = ""
    "xcplayground" = ""
    "xhtml" = ""
    "xls" = ""
    "xlsx" = ""
    "xml" = ""
    "xul" = ""
    "xz" = ""
    "yaml" = ""
    "yml" = ""
    "zip" = ""
    "zsh" = ""
  '';
}
