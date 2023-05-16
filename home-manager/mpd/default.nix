{
  home-manager.sharedModules = [{
    services.mpd = {
      enable = true;
      extraConfig = ''
        auto_update "yes"
      '';
    };
  }];
}
