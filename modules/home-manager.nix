{
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [{
      home.stateVersion = "22.11";
      programs.man.generateCaches = true;
    }];

    users = {
      user = {
        home.username = "user";
        home.homeDirectory = "/home/user";
      };
    };
  };
}
