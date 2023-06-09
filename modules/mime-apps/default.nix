{
  home-manager.sharedModules = [
    {
      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "image/png" = "feh.desktop";
          "image/jpeg" = "feh.desktop";
          "image/gif" = "org.qutebrowser.qutebrowser.desktop";
          "application/x-wine-extension-osz" = "osu-stable.desktop";
          "application/x-vmware-vm" = "vmware-workstation.desktop";
        };
      };
    }
  ];
}
