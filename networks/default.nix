{
  plasma = { pkgs, ... }: {
    imports = [
      ../modules/virtualization.nix
      ../modules/user.nix
      ../modules/plasma.nix
      ../modules/pipewire.nix
    ];
    environment.systemPackages = with pkgs; [
      kitty
      librewolf
    ];
  };
  gnome = { pkgs, ... }: {
    imports = [
      ../modules/virtualization.nix
      ../modules/user.nix
      ../modules/gnome.nix
      ../modules/pipewire.nix
    ];
    environment.systemPackages = with pkgs; [
      kitty
      librewolf
    ];
  };
}
