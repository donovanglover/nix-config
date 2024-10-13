{
  lib,
  buildNpmPackage,
  fetchFromGitHub,
}:

buildNpmPackage rec {
  pname = "all-the-package-names";
  version = "2.0.1794";

  src = fetchFromGitHub {
    owner = "nice-registry";
    repo = "all-the-package-names";
    rev = "v${version}";
    hash = "sha256-B91XRiyZ/cheUM02BQi/cSesf6dFOHwV21m+HQNkTbo=";
  };

  npmDepsHash = "sha256-32Vp6oVI5pHcuCvImRtJvE6/4A/xNlEQM/vkqgTtyRk=";

  meta = {
    description = "List of all the public package names on npm";
    homepage = "https://github.com/nice-registry/all-the-package-names";
    license = lib.licenses.mit;
    mainProgram = "all-the-package-names";
    maintainers = with lib.maintainers; [ donovanglover ];
  };
}
