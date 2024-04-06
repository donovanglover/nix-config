{ nix-config, pkgs, ... }:

let
  inherit (builtins) attrValues;
in
{
  imports = attrValues {
    inherit (nix-config.nixosModules) system shell;

    customConfig = {
      modules.system.username = "demo";
    };
  };

  home-manager.sharedModules = attrValues {
    inherit (nix-config.homeManagerModules) yazi;

    youCanNameThisAnything = {
      programs.btop.enable = true;
    };
  };

  environment.systemPackages = attrValues {
    inherit (nix-config.packages.x86_64-linux) webp-thumbnailer;

    inherit (pkgs) ruby php;
  };

  nixpkgs.overlays = attrValues {
    inherit (nix-config.overlays) kitty;

    exampleOverlay = final: prev: {
      btop = prev.btop.overrideAttrs (oldAttrs: {
        postInstall = (oldAttrs.postInstall or "") + /* bash */ ''
          echo "#!/usr/bin/env sh"  >> btop-overlay
          echo "echo 'hello world'" >> btop-overlay

          install -Dm755 btop-overlay $out/bin/btop-overlay
        '';
      });
    };
  };
}
