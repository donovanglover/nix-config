{
  services.logind = {
    lidSwitch = "ignore";
    extraConfig = "HandlePowerKey=ignore";
  };
}
