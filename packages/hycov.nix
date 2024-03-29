{
  lib,
  stdenv,
  hyprland,
  fetchFromGitHub,
  fetchpatch,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hycov";
  version = "0.36.0.1";

  src = fetchFromGitHub {
    owner = "DreamMaoMao";
    repo = "hycov";
    rev = finalAttrs.version;
    hash = "sha256-GHrgunfo+UARnf3OgNhdXoNFALRAmQEGhlZ8x5TBvkQ=";
  };

  patches = [
    # Update method signatures for Hyprland 0.37.0+
    (fetchpatch {
      url = "https://github.com/Ayuei/hycov/commit/db6ea8a24f0a58fa69f86db49d7c853754b1b8e1.patch";
      hash = "sha256-2FMHLmxuuBrui57d6kw6sfJJmtAV0vNF8sjFdaeIgf0=";
    })
  ];

  inherit (hyprland) nativeBuildInputs;

  buildInputs = [ hyprland ] ++ hyprland.buildInputs;

  meta = with lib; {
    homepage = "https://github.com/Ayuei/hycov";
    description = "Clients overview for hyprland plugin";
    license = licenses.mit;
    platforms = platforms.linux;
  };
})
