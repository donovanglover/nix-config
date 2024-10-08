{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage rec {
  pname = "all-the-package-names";
  version = "2.0.1669";

  src = fetchFromGitHub {
    owner = "nice-registry";
    repo = "all-the-package-names";
    rev = "v${version}";
    hash = "sha256-p0pt/mZoudMIMkLTksKCkSEO7yrixHNqGGnonpEGrO4=";
  };

  npmDepsHash = "sha256-F5kJJ5oA69xmv9VXVpegjcLHEnRtzGL3DV2kAghfDqY=";

  meta = {
    description = "List of all the public package names on npm";
    homepage = "https://github.com/nice-registry/all-the-package-names";
    license = lib.licenses.mit;
    mainProgram = "all-the-package-names";
    maintainers = with lib.maintainers; [ donovanglover ];
  };
}
