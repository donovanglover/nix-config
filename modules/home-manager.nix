{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [{
      home.stateVersion = "22.11";
    }];

    users = {
      user = {
        home.username = "user";
        home.homeDirectory = "/home/user";
      };
    };
  };
}
