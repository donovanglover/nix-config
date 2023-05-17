{ pkgs, lib, ... }:

{
  environment.systemPackages = with pkgs; [
    osu-lazer-bin
  ];

  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
    "osu-lazer-bin"
  ];
}
