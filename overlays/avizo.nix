final: prev: {
  avizo = prev.avizo.overrideAttrs (oldAttrs: {
    version = "1.3-unstable-2024-09-04";

    src = prev.fetchFromGitHub {
      owner = "heyjuvi";
      repo = "avizo";
      rev = "bc2fb780da58a312191edbf007fc3c8ef1e4eb15";
      hash = "sha256-aYA/ls6MLHuE/6noVff4LUEJzyh0EEs+u2dallnevcI=";
    };
  });
}
