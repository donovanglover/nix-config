{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    rustc
    rustfmt
    cargo
    rust-analyzer
  ];
}
