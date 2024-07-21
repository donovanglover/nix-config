{ pkgs, ... }:

let
  inherit (pkgs) ungoogled-chromium;
in
{
  programs.chromium = {
    enable = true;
    package = ungoogled-chromium;

    commandLineArgs = [
      "--ozone-platform=wayland"
      "--enable-wayland-ime"
      "--extension-mime-request-handling=always-prompt-for-install"
      "--webrtc-ip-handling-policy=default_public_interface_only"
    ];
  };
}
