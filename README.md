# Arch files

> Vim is my editor, \*nix is my IDE.

These are my Arch files. I use them with [Arch GNU/Linux](https://www.archlinux.org/).

The `sh` directory contains scripts that handle common installation procedures and other commands required to replicate any part of my setup.

The `dots` directory contains all my dotfiles. The scripts in the `sh` directory are in charge of stowing these files as needed.

For peace of mind, make sure to place this repository directory somewhere hidden yet easily accessible, ideally as a dot directory in your home path.

## What's Included

Arch Linux is great. You can turn it into whatever you want, whether that's a complete desktop environment or a DIY setup with a window manager, adding things piece by piece.

Here's what I recommend:

- Install **Xfce** if 1) your screen is not HiDPI, 2) you plan to use a lot of GTK applications, and 3) you want a minimal but usable setup for daily tasks.
- Install **Plasma** if 1) you want a desktop environment that supports HiDPI with minimal effort, 2) your computer is new enough that 1GB RAM idle is irrelevant, and 3) you want to take advantage of all the features a desktop environment can offer.
- Install **bspwm** if 1) you are tight on system resources, 2) you're fine with using the terminal and keyboard shortcuts for everything, and 3) you want to work with an advanced tty with better graphics and some GUI support.

All setups aim to have the following features:

1. Universal theming
2. Vim-inspired keybindings
3. Easily reproducible

## Dots

I manage my dotfiles with `stow`. Different dotfiles are stored in different directories. You can "install" a set of dotfiles with `stow <dir>`, e.g. `stow bspwm`.

My dotfiles are sorted by directory based on 1) whether or not they are DE/WM specific and 2) whether or not they are software specific.

I try to document many things in both my dotfiles and scripts. If you don't know what something means, try searching on Stack Exchange or the Arch Wiki. When in doubt, just `man software` and `/search` for what you need to know!
