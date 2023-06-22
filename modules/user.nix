{ config, ... }: {
  users = {
    mutableUsers = false;

    users."${config.variables.username}" = {
      isNormalUser = true;
      uid = 1000;
      password = "user";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };
}
