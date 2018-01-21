# New Start

[![GPLv3 License](https://img.shields.io/badge/License-GPLv3-444267.svg?style=for-the-badge&colorA=676E95)](https://www.gnu.org/licenses/gpl-3.0.en.html)
[![Creative Commons BY-SA](https://img.shields.io/badge/Creative_Commons-BY&ndash;SA-444267.svg?style=for-the-badge&colorA=676E95)](https://creativecommons.org/licenses/by-sa/4.0/)
[![Uses Crystal](https://img.shields.io/badge/Uses-Crystal-444267.svg?style=for-the-badge&colorA=676E95)](https://crystal-lang.org)

> Vim is my editor, \*nix is my IDE.

![Screenshot](etc/preview.jpg?raw=true)
![Screenshot](etc/preview2.jpg?raw=true)

New Start is built on top of [Arch GNU/Linux](https://www.archlinux.org/) and consists of my [dotfiles](dotfiles/), [install scripts](install/), [help files](help/), and [custom software](src/).

## Features

- Universal themes
    - All Base16 themes supported.
    - It is trivial to make your own themes.
    - One command to change the color schemes in all the software you use.
- Mouse-free
    - Never reach for your mouse again.
    - Vim-inspired keybindings.
- Reproducability
    - Install the system from scratch and have the exact same configuration as before.
    - It is trivial to make your own live usb of the system.

## Before You Begin

1. [Linux is not an operating system](https://www.gnu.org/gnu/linux-and-gnu.html). All the so-called "Linux" distributions are actually distributions of [GNU/Linux](https://www.gnu.org/gnu/gnu-users-never-heard-of-gnu.html).
2. [Arch GNU/Linux is rolling-release](https://wiki.archlinux.org/index.php/Arch_Linux). There is no such thing as having to install a new version of Arch.
3. [Free software gives you complete control over your computing](https://www.gnu.org/philosophy/free-sw.html). If something doesn't work, it's more often than not user error.
4. [Keep it simple](https://en.wikipedia.org/wiki/Minimalism_(computing)). At the end of the day, you only need to use your computer for a few specific tasks, such as listening to music, writing software, sending messages, and using the internet. [Don't overcomplicate things](https://en.wikipedia.org/wiki/KISS_principle).

This system is different from your traditional point-click system. There is no such thing as "clicking the close button" here, or clicking anything for that matter.

Once mastered, the interface should not get in the way. Everything just works.

## Installation

For installation, I assume that you already have a base Arch installation.

Install the packages from your local user account:

```shell
git clone https://github.com/GloverDonovan/new-start
cd new-start
makepkg
sudo pacman -U *.xz
```

If you don't have one already, install an AUR helper:

```shell
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg
sudo pacman -U *.xz
```

Next, use your AUR helper to install the AUR packages:

```shell
yay -S shotgun polybar ttf-noto htop-vim-git inox-bin waterfox-bin
```

Then choose which dotfiles you want to use:

```shell
mv dotfiles ~
cd ~/dotfiles
stow bspwm # Change this to whatever you want
```

Finally run `startx` and you should have a working system!

**NOTE**: Above is just a prototype and is not finalized. Expect changes.

## Getting Started

### Dotfiles

My dotfiles aim to be simple, straight-forward, and to the point. If you want to know how something works, just `man software` and `/search` for what you need to know!

- [`polybar/config`](dotfiles/.config/polybar/config)
- [`.zshrc`](dotfiles/.zshrc)
- [`userChrome.css`](etc/userChrome.css) - A bare-minimum browser that emphasizes keyboard usage
- [`user.js`](etc/user.js) - Settings to make using the browser a more pleasurable experience

Some of the software I use include (in no particular order):

- [neovim](https://github.com/neovim/neovim)
- [ranger](https://github.com/ranger/ranger)
- [feh](https://github.com/derf/feh)
- [mpv](https://github.com/mpv-player/mpv)
- [zathura](https://github.com/pwmt/zathura)
- [yay](https://github.com/Jguer/yay)
- [polybar](https://github.com/jaagr/polybar)
- [shotgun](https://github.com/Streetwalrus/shotgun)
- [inox](https://github.com/gcarq/inox-patchset)
- [waterfox](https://github.com/MrAlex94/Waterfox)
- [mpd](https://github.com/MusicPlayerDaemon/MPD) + [mpc](https://github.com/MusicPlayerDaemon/mpc) + [ncmpcpp](https://github.com/arybczak/ncmpcpp)
- [bspwm](https://github.com/baskerville/bspwm) + [sxhkd](https://github.com/baskerville/sxhkd)

For a complete list of the packages included, see the [`PKGBUILD`](PKGBUILD).

### Help Files

Help files are a way for me to keep track of all the useful commands I learn about certain software. They're compiled in easy-to-read files so I don't have to search the same thing over and over.

- [`commands.md`](help/commands.md) - The majority of terminal commands I use on a daily basis
- [`git.md`](help/git.md) - There's a lot more to Git than you think (no pun intended)
- [`gpg.md`](help/gpg.md) - Everything you need to know about GPG
- [`profanity.md`](help/profanity.md) - A primer on using XMPP with Profanity
- [`vim.md`](help/vim.md) - A complete reference to everything I know (and find worth mentioning) about vim

## Contributing

If you want to improve the help files or other parts of New Start then please file an issue first. Pull requests are accepted, but I'd prefer if you made an issue first!

## License

- Code is released under the GPLv3 license.
- The [`install-guide.sh`](install-guide.sh) and help files are released under the Creative Commons BY-SA license.
