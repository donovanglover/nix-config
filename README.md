# New Start

> Vim is my editor, \*nix is my IDE.

- Window manager: [bspwm][bspwm] with [`XDG_CURRENT_DESKTOP=KDE`][kde]
- Bar: [polybar][polybar]
- Launcher: [rofi][rofi]
- Icons: [Papirus][papirus]

## Usage

I manage my dotfiles with [`stow`][stow]. Once you have stow installed, run:

```shell
make install
```

> **Note**: Some of my config files are optimized for HiDPI (between 180 and 192dpi). Adjust those numbers for your display accordingly, or simply don't stow those files.

If you want to learn how to make your system work for you, see [What is GNU/Linux?][gnulinux] and [What is free software?][freesw].

[archlinux]:  https://www.archlinux.org
[fedora]:     https://getfedora.org
[polybar]:    https://github.com/jaagr/polybar
[bspwm]:      https://github.com/baskerville/bspwm
[rofi]:       https://github.com/DaveDavenport/rofi
[papirus]:    https://github.com/PapirusDevelopmentTeam/papirus-icon-theme
[gnulinux]:   https://www.gnu.org/gnu/linux-and-gnu.html
[freesw]:     https://www.gnu.org/philosophy/free-sw.html
[kde]:        https://wiki.archlinux.org/index.php/Qt#Configuration_of_Qt5_apps_under_environments_other_than_KDE_Plasma
[stow]:       https://www.gnu.org/software/stow/manual/stow.html
