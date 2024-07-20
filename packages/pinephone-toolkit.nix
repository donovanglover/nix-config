{ lib
, stdenv
, fetchFromGitHub
, meson
, ninja
, pkg-config
}:

stdenv.mkDerivation {
  name = "pinephone-toolkit";
  version = "0-unstable-2021-03-22";

  src = fetchFromGitHub {
    owner = "Dejvino";
    repo = "pinephone-toolkit";
    rev = "0107cf984fe5d04dc876a18139cc0c52d6bd6046";
    hash = "sha256-jANYWAKBKvDGUDDCcqKplyJ1LZDigGvQkN0melWFpzo=";
  };

  nativeBuildInputs = [
    meson
    ninja
    pkg-config
  ];

  meta = {
    description = "Tools and utilities for the PINE64 PinePhone";
    homepage = "https://github.com/Dejvino/pinephone-toolkit";
    license = lib.licenses.asl20;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.linux;
  };
}
