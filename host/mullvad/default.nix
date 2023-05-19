{ pkgs, ... }:

{
  environment.systemPackages = [ pkgs.mullvad-vpn ];

  services.mullvad-vpn = {
    enable = true;
    enableExcludeWrapper = false;
  };

  networking = {
    nat = {
      enable = true;
      internalInterfaces = [ "ve-+" ];
      externalInterface = "wg-mullvad";
    };

    networkmanager = {
      unmanaged = [ "interface-name:ve-*" ];
    };
  };
}
