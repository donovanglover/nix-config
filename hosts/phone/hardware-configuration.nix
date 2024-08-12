{ lib, ... }:

{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/c27b4193-56f0-44e8-bc45-6f64e4b721da";
      fsType = "ext4";
    };
  };

  nix.settings.max-jobs = lib.mkDefault 2;
}
