{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [{
      home.stateVersion = "22.11";
    }];
  };
}
