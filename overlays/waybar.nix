{
  nixpkgs.overlays = [
    (final: prev: {
      waybar = prev.waybar.overrideAttrs (old: rec {
        version = "635e06209dcf14612549864f461847f94b86406b";

        src = final.fetchFromGitHub {
          owner = "varbhat";
          repo = "Waybar";
          rev = version;
          sha256 = "sha256-9D+OTPVvjnjCl3OW/YUoFmDi8IJLs/8QTi5JUorLmL8=";
        };

        postPatch = /* bash */ ''
          sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
        '';

        mesonFlags = old.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}
