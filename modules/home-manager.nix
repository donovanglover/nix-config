let VARIABLES = import ../src/variables.nix; in {
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    sharedModules = [{
      home.stateVersion = VARIABLES.stateVersion;
    }];

    users = {
      user = {
        home.username = VARIABLES.username;
        home.homeDirectory = "/home/${VARIABLES.username}";
      };
    };
  };
}
