{
  home-manager = {
    useGlobalPkgs = true;

    sharedModules = [{
      home.stateVersion = "22.11";
    }];
  };
}
