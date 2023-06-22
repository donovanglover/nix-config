{ config, ... }: {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [{
      home.stateVersion = config.variables.stateVersion;
    }];

    users = {
      user = {
        home.username = config.variables.username;
        home.homeDirectory = "/home/${config.variables.username}";
      };
    };
  };
}
