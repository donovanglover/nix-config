{ lib
, stdenv
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "go-thumbnailer";
  version = "0.1.0";

  src = fetchFromGitHub {
    owner = "donovanglover";
    repo = pname;
    rev = "${version}";
    hash = lib.fakeSha256;
  };

  # proxyVendor = true;
  vendorSha256 = lib.fakeSha256;

  postInstall = ''
    mkdir -p $out/share/thumbnailers
    substituteAll ${./go.thumbnailer} $out/share/thumbnailers/go.thumbnailer
  '';

  meta = with lib; {
    description = "A cover thumbnailer written in Go for performance and reliability.";
    homepage = "https://github.com/donovanglover/go-thumbnailer";
    license = licenses.mit;
    maintainers = [ ];
  };
}
