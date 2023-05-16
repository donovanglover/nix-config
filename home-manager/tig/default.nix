{
  home-manager.sharedModules = [{
    xdg.configFile."tig/config".text = ''
      color cursor black green bold
      color title-focus black blue bold
      color title-blur black blue bold
    '';
  }];
}
