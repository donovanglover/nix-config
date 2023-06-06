{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.callPackage ../../packages/joshuto {})
  ];

  home-manager.sharedModules = [
    {
      xdg.configFile."joshuto/joshuto.toml".text = ''
        [display]
        automatically_count_files = true
        show_borders = false
        show_hidden = true
        line_number_style = "absolute"
        collapse_preview = false

        [preview]
        max_preview_size = 10000000000
        preview_script = "~/.config/joshuto/preview.sh"
        preview_shown_hook_script = "~/.config/joshuto/kitty-show.sh"
        preview_removed_hook_script = "~/.config/joshuto/kitty-remove.sh"
      '';

      xdg.configFile."joshuto/preview.sh".source = ./preview.sh;
      xdg.configFile."joshuto/kitty-show.sh".source = ./kitty-show.sh;
      xdg.configFile."joshuto/kitty-remove.sh".source = ./kitty-remove.sh;
    }
  ];
}
