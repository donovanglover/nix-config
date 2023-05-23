{ pkgs, lib, ... }:

{
  home-manager.sharedModules = [{
    programs.rofi = {
      enable = true;
      package = (pkgs.callPackage ./package/wrapper.nix {
        rofi-unwrapped = (pkgs.callPackage ./package/wayland.nix { });
      });
      cycle = false;
      extraConfig = {
        modi = "drun,filebrowser";
        font = "Noto Sans CJK JP 12";
        show-icons = true;
        bw = 0;
        display-drun = "";
        display-window = "";
        display-combi = "";
        icon-theme = "Fluent-dark";
        terminal = "kitty";
        drun-match-fields = "name";
        drun-display-format = "{name}";
        me-select-entry = "";
        me-accept-entry = "MousePrimary";
      };
      theme = lib.mkForce ./launchpad.rasi;
    };
  }];
}
