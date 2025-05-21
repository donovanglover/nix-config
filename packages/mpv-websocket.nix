{
  lib,
  rustPlatform,
  fetchFromGitHub,
}:

rustPlatform.buildRustPackage (finalAttrs: {
  pname = "mpv-websocket";
  version = "0.4.1";

  src = fetchFromGitHub {
    owner = "kuroahna";
    repo = "mpv_websocket";
    tag = finalAttrs.version;
    hash = "sha256-a2/TMTl9QIU7oKqm9yv/SFLwpKArMdGjJZjaTyUwXfM=";
  };

  cargoHash = "sha256-avBHcFJW5SvAZDISKUcEwL6Wxa4hiKQPljEx5eHswDE=";

  meta = {
    description = "WebSocket plugin for mpv";
    homepage = "https://github.com/kuroahna/mpv_websocket";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ donovanglover ];
    mainProgram = "mpv_websocket";
  };
})
