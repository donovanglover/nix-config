{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "mpv-websocket";
  version = "0.4.4";

  src = fetchFromGitHub {
    owner = "kuroahna";
    repo = "mpv_websocket";
    tag = finalAttrs.version;
    hash = "sha256-e8t8R+SMcMAKyfL1SwKcUuW1qRBXNtx/LPJrqNbRyw4=";
  };

  cargoHash = "sha256-fcYucTUP9fDqO7zdCjZvSmB16gFpbBXAo1DPhDBw4z0=";

  patchPhase = ''
    runHook prePatch

    substituteInPlace src/main.rs \
      --replace-fail 'exe_path.join("logs")' 'std::env::temp_dir().join("mpv_websocket")'

    runHook postPatch
  '';

  meta = {
    description = "WebSocket plugin for mpv";
    homepage = "https://github.com/kuroahna/mpv_websocket";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ donovanglover ];
    mainProgram = "mpv_websocket";
  };
})
