final: prev: {
  xdg-desktop-portal-hyprland = prev.xdg-desktop-portal-hyprland.overrideAttrs (oldAttrs: rec {
    version = "1.3.3";

    src = prev.fetchFromGitHub {
      owner = "hyprwm";
      repo = "xdg-desktop-portal-hyprland";
      rev = "v${version}";
      hash = "sha256-cyyxu/oj4QEFp3CVx2WeXa9T4OAUyynuBJHGkBZSxJI=";
    };

    patches = [ ];
  });
}
