{ pkgs, ... }:

{
  imports = [
    ./editorconfig
    ./nix
    ./npm
    ./rust
  ];

  environment.systemPackages = with pkgs; [
    marksman
    gopls
    lua-language-server
    clang-tools
    texlab
  ];
}
