{ pkgs, ... }:

{
  programs.htop = {
    enable = true;
    package = pkgs."htop-vim";
    settings = { tree_view = 1; };
  };
}
