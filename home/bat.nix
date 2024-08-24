{ lib, ... }:

{
  programs.bat = {
    enable = true;

    config = {
      theme = lib.mkForce "base16";
    };
  };
}
