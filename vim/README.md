# Vim

I use neovim as my main text editor, and vim elsewhere.

## Dependencies

- [vim][vim] - If you're reading this, you probably already know what vim is
- [neovim][neovim] - An improved version of vim (cursor modes, sane defaults, etc.)
- [python-pywal][python-pywal] - Changing color schemes support
- [fzf][fzf] - Fuzzy search support
- [ripgrep][ripgrep] - Jump between lines in files
- [git][git] - Git diff support
- Any other features you want to use (e.g. TeX support with [texlive-core][texlive-core])

## Installation

```sh
make package=vim
```

## Usage

I use [vim-plug][vim-plug] as my plugin manager of choice. If it isn't installed already, my `.vimrc` will install it for you. If you already have vim-plug installed, run `:PlugInstall`. Now you can use my vim config with all the plugins enabled!

[vim-plug]: https://github.com/junegunn/vim-plug
[vim]: https://www.archlinux.org/packages/extra/x86_64/vim/
[neovim]: https://www.archlinux.org/packages/community/x86_64/neovim/
[python-pywal]: https://www.archlinux.org/packages/community/any/python-pywal/
[fzf]: https://www.archlinux.org/packages/community/x86_64/fzf/
[ripgrep]: https://www.archlinux.org/packages/community/x86_64/ripgrep/
[git]: https://www.archlinux.org/packages/extra/x86_64/git/
[texlive-core]: https://www.archlinux.org/packages/extra/any/texlive-core/
