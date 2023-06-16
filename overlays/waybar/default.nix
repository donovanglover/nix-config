{
  nixpkgs.overlays = [
    (final: prev: {
      waybar = prev.waybar.overrideAttrs (old: {
        postPatch = /* bash */ ''
          # use hyprctl to switch workspaces
          sed -i 's/zext_workspace_handle_v1_activate(workspace_handle_);/const std::string command = "hyprctl dispatch workspace e+1";\n\tsystem(command.c_str());/g' src/modules/wlr/workspace_manager.cpp
        '';

        mesonFlags = old.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
  ];
}
