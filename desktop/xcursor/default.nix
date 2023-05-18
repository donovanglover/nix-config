{
  home-manager.sharedModules = [{
    home.file.".icons/default/index.theme".text = ''
      [icon theme]
      Inherits=phinger-cursors
    '';
  }];
}
