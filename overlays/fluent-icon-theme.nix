final: prev: {
  fluent-icon-theme = prev.fluent-icon-theme.overrideAttrs {
    dontCheckForBrokenSymlinks = true;
  };
}
