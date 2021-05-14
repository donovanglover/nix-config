# Code

> NOTE: As of 2021, I have no interest in the (vs)code text editor. Although the out-of-the-box features are nice and all, trying to emulate vim-like functionality was more pain than it was worth (even after using [vscode-neovim][vscode-neovim]). Additionally, the battery drain is unreal compared to running an equivalent [neovim](/neovim) experience.

![Screenshot of Code with pywal support.](/.archlinux/screenshots/code.jpg?raw=true)

> If you want (vs)code to honor [pywal](/wal) color schemes, use [vscode-wal][vscode-wal].

[Code][code] is an open source build of [a popular][vscode] GUI text editor.

## Use Cases

Code can be used to:

- Navigate graphical file trees entirely with the mouse
- Provide an editor for non-vim users as needed
- Perform a myriad of common command line operations through a point-click GUI

You should not use Code if:

- You want to learn how compilers, git, find, grep, and other software work
- You want to learn [vim](/vim), the standard text editor

## Usage

Once Code is installed, run `make code-extensions` to install the extensions I use.

[code]: https://www.archlinux.org/packages/community/x86_64/code/
[vscode]: https://github.com/Microsoft/vscode
[vscode-neovim]: https://github.com/asvetliakov/vscode-neovim
[vscode-wal]: https://github.com/bluedrack/vscode-wal
