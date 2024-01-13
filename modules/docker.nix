{ pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
