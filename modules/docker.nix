{ pkgs, ... }:

{
  virtualisation.docker.enable = true;
  virtualisation.docker.enableOnBoot = false;
  virtualisation.podman.enable = true;

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
