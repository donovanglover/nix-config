{
  lib,
  buildGoModule,
  fetchFromGitHub,
  pkg-config,
  gtk3,
  gtk-layer-shell,
}:
buildGoModule rec {
  pname = "nwg-dock-hyprland";
  version = "0.1.2";

  src = fetchFromGitHub {
    owner = "nwg-piotr";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-7vdfxE3X2J7bDLzose0dKmjxNQhS5+/ROky9wkK1gc0=";
  };

  vendorSha256 = "sha256-GhcrIVnZRbiGTfeUAWvslOVWDZmoL0ZRnjgTtQgxe2Q=";

  ldflags = ["-s" "-w"];

  nativeBuildInputs = [pkg-config];
  buildInputs = [gtk3 gtk-layer-shell];

  meta = with lib; {
    description = "GTK3-based dock for hyprland";
    homepage = "https://github.com/nwg-piotr/nwg-dock-hyprland";
    license = licenses.mit;
    platforms = platforms.linux;
    maintainers = with maintainers; [dit7ya];
  };
}
