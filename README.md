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

## Philosophy

1. Use configuration files for everything. Make it easy to replicate your entire setup on multiple machines, without having to manually click through things or add obscurely large "config" files.
2. Changing themes should make the computer feel completely different, but not affect the functionality itself.

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
makepkg -si
sudo pacman -U *.xz
```

If you don't have one already, install an AUR helper:

```shell
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
sudo pacman -U *.xz
```

Next, use your AUR helper to install the AUR packages:

```shell
yay -S shotgun polybar ttf-noto htop-vim-git inox-bin \
       waterfox-bin arch-silence-grub-theme launch-cmd
```

Enable the Arch Silence GRUB theme:

```shell
grub-mkconfig -o /boot/grub/grub.cfg
```

Install crystal ctags:

```shell
git clone https://github.com/SuperPaintman/crystal-ctags
cd crystal-ctags
sudo make install
```

Install all the vim plugins:

```shell
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
```

Add the `undo` directory for regular vim:

```shell
mkdir ~/.vim/undo
```

Then choose which dotfiles you want to install:

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

If you want to use an alternative DNS server (such as [OpenNIC](https://www.opennic.org/)), put the following in your `etc/resolv.conf`:

```
nameserver # IP of nameserver 1
nameserver # IP of nameserver 2 (fallback #1)
nameserver # IP of nameserver 3 (fallback #2)
options timeout:1
```

Other things I use:

- Display Server: [xorg](https://wiki.archlinux.org/index.php/Xorg)
- Sound System: [alsa](https://wiki.archlinux.org/index.php/Advanced_Linux_Sound_Architecture)
- Boot Loader: [grub](https://wiki.archlinux.org/index.php/GRUB)
- GRUB Theme: [arch-silence](https://github.com/fghibellini/arch-silence)
- Vim Keybindings: [VimFx](https://github.com/akhodakivskiy/VimFx), [Vimium](https://github.com/philc/vimium)
- Secure Connection: [HTTPS Everywhere](https://github.com/EFForg/https-everywhere)
- (vim) Plugin manager: [vim-plug](https://github.com/junegunn/vim-plug)

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
