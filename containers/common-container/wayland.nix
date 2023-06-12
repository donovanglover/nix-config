{
  bindMounts = {
    waylandDisplay = rec {
      hostPath = "/run/user/1000";
      mountPoint = hostPath;
    };

    x11Display = rec {
      hostPath = "/tmp/.X11-unix";
      mountPoint = hostPath;
      isReadOnly = true;
    };
  };
}
