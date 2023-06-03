{ pkgs, ... }:

{
  imports = [
    ./feh
    ./kitty
    ./librewolf
    ./mpv
    ./piper
    ./qutebrowser
    ./thunar
    ./zathura
  ];

  virtualisation.vmware.host = {
    enable = true;
    extraConfig = ''
      # Enable 3D acceleration on the host
      mks.gl.allowUnsupportedDrivers = "TRUE"
      mks.vk.allowUnsupportedDevices = "TRUE"
    '';
  };

  environment.systemPackages = with pkgs; [
    audacity
    gimp
    anki
    logseq
    mullvad-browser
    spek
    keepassxc
    libreoffice
  ];
}
