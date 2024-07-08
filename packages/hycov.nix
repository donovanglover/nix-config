{ lib
, stdenv
, hyprland
, fetchFromGitHub
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "hycov";
  version = "0.41.2.1";

  src = fetchFromGitHub {
    owner = "DreamMaoMao";
    repo = "hycov";
    rev = finalAttrs.version;
    hash = "sha256-NRnxbkuiq1rQ+uauo7D+CEe73iGqxsWxTQa+1SEPnXQ=";
  };

  inherit (hyprland) nativeBuildInputs;

  buildInputs = [ hyprland ] ++ hyprland.buildInputs;

  meta = {
    description = "Clients overview for hyprland plugin";
    homepage = "https://github.com/DreamMaoMao/hycov";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.linux;
  };
})
