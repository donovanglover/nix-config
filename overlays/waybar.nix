{
  nixpkgs.overlays = [
    (final: prev: {
      waybar = prev.waybar.overrideAttrs (old: rec {
        version = "b0f89f2bc115f4447dbf4565faca9a6122594d68";

        src = final.fetchFromGitHub {
          owner = "Alexays";
          repo = "Waybar";
          rev = version;
          sha256 = "sha256-wH8UvSYnEBCdF2r6yAtocVuaZM9eIXLlg31n9FKTISE=";
        };

        postPatch = /* bash */ ''
          # use hyprctl to switch workspaces
          sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace " + name_;\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
        '';

        mesonFlags = old.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}
