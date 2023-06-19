{
  services.logind = {
    # Don't suspend on lid close
    lidSwitch = "ignore";

    # Don't shutdown when power button is short-pressed
    extraConfig = "HandlePowerKey=ignore";
  };
}
