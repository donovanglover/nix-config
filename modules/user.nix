let VARIABLES = import ../src/variables.nix; in {
  users = {
    mutableUsers = false;

    users."${VARIABLES.username}" = {
      isNormalUser = true;
      uid = 1000;
      password = "user";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };
}
