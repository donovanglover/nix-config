{ lib, ... }:

{
  programs.fzf = {
    enable = true;
    colors = lib.mkForce { };

    defaultOptions = [
      "--height 40%"
      "--reverse"
      "--border"
      "--color=16"
    ];

    defaultCommand = "rg --files --hidden --glob=!.git/";
  };
}
