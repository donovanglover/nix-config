{
  home-manager.sharedModules = [{
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
  }];
}
