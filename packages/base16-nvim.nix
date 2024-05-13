{ lib
, vimUtils
, fetchFromGitHub
}:

vimUtils.buildVimPlugin {
  pname = "base16-nvim";
  version = "2024-02-17";

  src = fetchFromGitHub {
    owner = "RRethy";
    repo = "base16-nvim";
    rev = "b3e9ec6a82c05b562cd71f40fe8964438a9ba64a";
    hash = "sha256-l0BO2boIy6mwK8ISWS3D68f8egqHYwsGSAnzjbB5aOE=";
  };

  meta = {
    description = "Neovim plugin for base16 color schemes";
    homepage = "https://github.com/RRethy/base16-nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ donovanglover ];
    platforms = lib.platforms.all;
  };
}
