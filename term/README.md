# Term

Here you will find the dotfiles I use specifically for the terminal emulators `termite` and `urxvt`.

## Dependencies

- [termite][termite] - Terminal with true transparency, icon fonts, true color, and emoji support
- [rxvt-unicode-patched][rxvt-unicode-patched] - Terminal with image support

## Installation

```sh
make package=term
```

## Usage

If you haven't already, `xrdb -merge ~/.Xresources`. Note that `.Xresources` should be loaded with one of your init scripts.

[termite]: https://www.archlinux.org/packages/community/x86_64/termite/
[rxvt-unicode-patched]: https://aur.archlinux.org/packages/rxvt-unicode-patched/
