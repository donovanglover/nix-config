# bspwm

I use `bspwm` as my window manager of choice. My setup is optimized for HiDPI, so you will have to manually adjust the numbers if you aren't using a HiDPI display.

## Dependencies

- [bspwm][bspwm] - Window manager
- [polybar][polybar] - Panel
- [dunst][dunst] - Notifications
- [rofi][rofi] - Window switcher, application launcher, and dmenu replacement
- [sxhkd][sxhkd] - Keybinds
- [rxvt-unicode-patched][rxvt-unicode-patched] - Terminal for image support
- [termite][termite] - Terminal for transparency and everything else
- [python-pywal][python-pywal] - A universal color scheme changer
- [feh][feh] - Used to set the background image

## Installation

```sh
make package=bspwm
```

## Usage

Either `startx` directly or use a display manager. Assuming you have the necessary dependencies installed, and assuming you configured your system properly, everything should just work.

[bspwm]: https://www.archlinux.org/packages/community/x86_64/bspwm/
[polybar]: https://aur.archlinux.org/packages/polybar/
[dunst]: https://www.archlinux.org/packages/community/x86_64/dunst/
[rofi]: https://www.archlinux.org/packages/community/x86_64/rofi/
[sxhkd]: https://www.archlinux.org/packages/community/x86_64/sxhkd/
[termite]: https://www.archlinux.org/packages/community/x86_64/termite/
[rxvt-unicode-patched]: https://aur.archlinux.org/packages/rxvt-unicode-patched/
[python-pywal]: https://www.archlinux.org/packages/community/any/python-pywal/
[feh]: https://www.archlinux.org/packages/extra/x86_64/feh/
