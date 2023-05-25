{
  users = {
    mutableUsers = false;

    users.user = {
      isNormalUser = true;
      uid = 1000;
      password = "user";
      extraGroups = [ "wheel" "networkmanager" ];
    };
  };

  home-manager.users.user = {
    home.username = "user";
    home.homeDirectory = "/home/user";
  };
}
