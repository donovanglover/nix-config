{
  nixpkgs.overlays = [
    (import ./base16-schemes.nix)
    (import ./kitty.nix)
    (import ./srb2.nix)
    (import ./zola.nix)
  ];
}
