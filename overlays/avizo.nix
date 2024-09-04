final: prev: {
  avizo = prev.avizo.overrideAttrs (oldAttrs: {
    src = prev.fetchFromGitHub {
      owner = "donovanglover";
      repo = "avizo";
      rev = "e5e51a14768e6c3c273f2e121a3fca71cc30f3b9";
      hash = "sha256-FZn1HOnBNyqj448egH2H5FZc0ApKMWH6i8iM2qoHaRs=";
    };
  });
}
