{ pkgs, ... }:

{
  programs.chromium = {
    enable = true;
    package = pkgs.ungoogled-chromium;

    commandLineArgs = [
      "--extension-mime-request-handling=always-prompt-for-install"
      "--webrtc-ip-handling-policy=default_public_interface_only"
    ];
  };
}
