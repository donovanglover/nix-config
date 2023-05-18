{
  home-manager.sharedModules = [{
    services.gpg-agent = {
      enable = true;
      pinentryFlavor = "curses";
      defaultCacheTtl = 43200;
      maxCacheTtl = 43200;
    };
  }];
}
