{
  nix-config,
  pkgs,
  lib,
  ...
}:

let
  inherit (lib) singleton mkMerge;
  inherit (builtins) attrValues;
in
{
  imports = attrValues {
    inherit (nix-config.nixosModules) system shell desktop;

    customConfig = {
      modules.system.username = "asuna";
    };
  };

  home-manager.sharedModules =
    attrValues nix-config.homeModules
    ++ singleton {
      programs.btop.enable = true;
    };

  environment.systemPackages = mkMerge [
    (with pkgs; [
      ruby
      php
    ])

    (with nix-config.packages.${pkgs.system}; [
      webp-thumbnailer
    ])
  ];

  nixpkgs.overlays = attrValues nix-config.overlays ++ [
    (final: prev: {
      btop = prev.btop.overrideAttrs (oldAttrs: {
        postInstall =
          (oldAttrs.postInstall or "")
          # bash
          + ''
            echo "#!/usr/bin/env sh"  >> btop-overlay
            echo "echo 'hello world'" >> btop-overlay

            install -Dm755 btop-overlay $out/bin/btop-overlay
          '';
      });
    })
  ];
}
