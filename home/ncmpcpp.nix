{ pkgs, ... }:

let
  inherit (pkgs) mpc-cli;

  musicDirectory = "/home/user/音楽";
  changeScript = "ncmpcpp/on-song-change.sh";
  fallbackImage = ../assets/wallpaper.png;
in
{
  home.packages = [ mpc-cli ];

  services.mpd = {
    enable = true;
    inherit musicDirectory;

    extraConfig = /* config */ ''
      auto_update "yes"
    '';
  };

  xdg.configFile.${changeScript} = {
    executable = true;
    text = /* bash */ ''
      #!/usr/bin/env bash

      find_cover () {
        ext="$(mpc --format %file% current | sed 's/^.*\.//')"

        if [ "$ext" == "flac" ]; then
          metaflac --export-picture-to=/tmp/cover.jpg \
          "$(mpc --format "${musicDirectory}"/%file% current)" && cover_path="/tmp/cover.jpg" && return
        else
          ffmpeg -y -i "$(mpc --format "${musicDirectory}"/%file% | head -n 1)"} \
          /tmp/cover.jpg && cover_path="/tmp/cover.jpg" && return
        fi

        file="${musicDirectory}/$(mpc --format %file% current)"
        album="''${file%/*}"
        cover_path=$(find "$album" -maxdepth 1 | grep -m 1 ".*\.\(jpg\|png\|gif\|bmp\)")
      }

      find_cover && notify-send -i "''${cover_path:-${fallbackImage}}" "Now Playing" "$(mpc current)"
    '';
  };

  programs.ncmpcpp = {
    enable = true;

    bindings = [
      { key = "mouse"; command = "dummy"; }
      { key = "h"; command = [ "previous_column" "jump_to_parent_directory" ]; }
      { key = "j"; command = "scroll_down"; }
      { key = "k"; command = "scroll_up"; }
      { key = "l"; command = [ "next_column" "enter_directory" "play_item" ]; }
      { key = "H"; command = [ "select_item" "scroll_down" ]; }
      { key = "J"; command = [ "move_sort_order_down" "move_selected_items_down" ]; }
      { key = "K"; command = [ "move_sort_order_up" "move_selected_items_up" ]; }
      { key = "L"; command = [ "select_item" "scroll_up" ]; }
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
      execute_on_song_change = "~/.config/${changeScript}";
      mpd_crossfade_time = 3;
    };
  };
}
