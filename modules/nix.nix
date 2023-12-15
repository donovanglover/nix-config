{ pkgs, ... }:

{
  nix = {
    package = with pkgs.nixVersions; nix_2_19;

    settings = {
      experimental-features = [ "nix-command" "flakes" "repl-flake" ];
      auto-optimise-store = true;
      warn-dirty = false;
    };
  };
}
