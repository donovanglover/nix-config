{ lib, ... }:

{
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/0a242de8-703e-46c1-a419-56109833aef5";
      fsType = "ext4";
    };
  };

  boot.initrd.luks.devices = {
    "LUKS-IPHONE-ROOTFS" = {
      device = "/dev/disk/by-uuid/969741b3-6cc3-4667-92e8-5f0240253e6f";
    };
  };

  nix.settings.max-jobs = lib.mkDefault 2;
}
