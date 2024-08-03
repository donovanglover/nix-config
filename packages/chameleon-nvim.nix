{ lib
, vimUtils
, fetchFromGitHub
}:

vimUtils.buildVimPlugin {
  pname = "chameleon-nvim";
  version = "0-unstable-2024-03-19";

  src = fetchFromGitHub {
    owner = "shaun-mathew";
    repo = "Chameleon.nvim";
    rev = "d682b970cc75a66c40cab77ab956ef44b0f82cd8";
    hash = "sha256-RRFTlybAlTbAuP1cU3WJVk8FZGvQqYR7LXWxenGcY0I=";
  };

  meta = {
    description = "Sync kitty's background color with your neovim colorscheme";
    homepage = "https://github.com/shaun-mathew/Chameleon.nvim";
    license = lib.licenses.mit;
    maintainers = with lib.maintainers; [ donovanglover ];
    mainProgram = "chameleon-nvim";
    platforms = lib.platforms.all;
  };
}
