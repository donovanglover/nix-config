{
  plasma = {
    imports = [
      ../modules/virtualization.nix
      ../modules/user.nix
      ../modules/plasma.nix
    ];
  };
  gnome = {
    imports = [
      ../modules/virtualization.nix
      ../modules/user.nix
      ../modules/gnome.nix
    ];
  };
}
