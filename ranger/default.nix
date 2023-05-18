{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.ranger ];

  home-manager.sharedModules = [{
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
  }];
}
