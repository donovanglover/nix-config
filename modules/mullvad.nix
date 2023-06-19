{ pkgs, ... }:

{
  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = false;
  };

  environment.systemPackages = with pkgs; [
    mullvad-vpn
  ];
}
