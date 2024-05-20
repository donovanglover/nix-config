{ pkgs, ... }:

{
  home.packages = with pkgs; [
    nodejs
    deno

    rustc
    rustfmt
    cargo
    cargo-info
    cargo-license
    cargo-feature
    cargo-tarpaulin
    cargo-edit
    bacon
    clippy

    texlive.combined.scheme-full
    tectonic
  ];
}
