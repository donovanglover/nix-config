final: prev: {
  avizo = prev.avizo.overrideAttrs (oldAttrs: {
    src = prev.fetchFromGitHub {
      owner = "donovanglover";
      repo = "avizo";
      rev = "8179e1d650a43065b2775ca9d316aee721c36a44";
      hash = "sha256-mWH+fqDD/wB/++0izp820t65zAr+s/kwx5jS2z3B4c0=";
    };
  });
}
