{ self, ... }:

{
  nixpkgs.overlays = with self.overlays; [
    base16-schemes
    kitty
    srb2
    zola
  ];
}
