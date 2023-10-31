{ pkgs, ... }:

{
  nixpkgs.overlays = [
    (final: prev: {
      cmus = prev.cmus.overrideAttrs (oldAttrs: {
        patches = (oldAttrs.patches or [ ]) ++ [
          # ffmpeg 6 fix https://github.com/cmus/cmus/pull/1254
          (pkgs.fetchpatch {
            url = "https://github.com/cmus/cmus/commit/07b368ff1500e1d2957cad61ced982fa10243fbc.patch";
            hash = "sha256-5gsz3q8R9FPobHoLj8BQPsa9s4ULEA9w2VQR+gmpmgA=";
          })
        ];
      });
    })
  ];
}
