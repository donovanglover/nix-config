final: prev: {
  kitty = prev.kitty.overrideAttrs (oldAttrs: rec {
    version = "0.41.0";

    src = prev.fetchFromGitHub {
      owner = "kovidgoyal";
      repo = "kitty";
      tag = "v${version}";
      hash = "sha256-5Yq4/zRqi5gK2obFTzGKR13FfyD7/G21C6WsA9QxFIg=";
    };
  });
}
