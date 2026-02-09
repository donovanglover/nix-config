{
  lib,
  fetchFromGitHub,
  python3Packages,
}:

python3Packages.buildPythonApplication rec {
  pname = "arib";
  version = "0.7.4";

  src = fetchFromGitHub {
    owner = "johnoneil";
    repo = "arib";
    tag = "v${version}";
    hash = "sha256-frKrBTcErBrjG5Urjhb1VXiota4pfhhrmmTQdt8f8W0=";
  };

  format = "pyproject";

  buildInputs = with python3Packages; [
    setuptools
    wheel
  ];

  propagatedBuildInputs = with python3Packages; [
    requests
  ];

  pythonImportsCheck = [ "arib" ];

  meta = {
    description = "ARIB MPEG-2 TS Closed Caption Decoding Tools";
    homepage = "https://github.com/johnoneil/arib";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
}
