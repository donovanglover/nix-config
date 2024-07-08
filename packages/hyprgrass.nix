{ lib
, stdenv
, hyprland
, fetchFromGitHub
, callPackage
, doctest
}:

let
  wf-touch = callPackage ./wf-touch.nix { };
in
stdenv.mkDerivation (finalAttrs: {
  pname = "hyprgrass";
  version = "0.7.0";

  src = fetchFromGitHub {
    owner = "horriblename";
    repo = "hyprgrass";
    rev = "v${finalAttrs.version}";
    hash = "sha256-DfM2BqnFW48NlHkBfC7ErHgK7WHlOgiiE+aFetN/yJ4=";
  };

  nativeBuildInputs = [
    doctest
  ] ++ hyprland.nativeBuildInputs;

  buildInputs = [
    hyprland
    wf-touch
  ] ++ hyprland.buildInputs;

  dontUseCmakeConfigure = true;

  doCheck = true;

  meta = {
    description = "Hyprland plugin for touch gestures";
    homepage = "https://github.com/horriblename/hyprgrass";
    license = lib.licenses.bsd3;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.linux;
  };
})
