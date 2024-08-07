{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;

    commandLineArgs = [
      "--ozone-platform=wayland"
      "--enable-wayland-ime"
      "--extension-mime-request-handling=always-prompt-for-install"
      "--webrtc-ip-handling-policy=default_public_interface_only"
    ];
  };
}
