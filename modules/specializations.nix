{ config, lib, ... }:

let
  cfg = config.modules.specializations;
in
{
  options.modules.specializations = {
    enable = lib.mkEnableOption "specializations";
  };

  config = lib.mkIf cfg.enable {
    specialisation = {
      gnome.configuration.imports = [ ../specializations/gnome.nix ];
      plasma.configuration.imports = [ ../specializations/plasma.nix ];
    };
  };
}
