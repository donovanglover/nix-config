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

## Getting Started

### Dotfiles

I know how frustrating it is to see a setup and not have access to the dotfiles. I also know how frustrating it is to go through dotfiles with default config settings everywhere or dotfiles with little to no documentation at all.

My goal here is simple: use as few config settings as possible required to make everything work, and document the settings that I do use. Your "config" file shouldn't be a `man` page!

- [`cmus/rc`](dotfiles/.config/cmus/rc)
- [`fontconfig/fonts.conf`](dotfiles/.config/fontconfig/fonts.conf)
- [`feh/keys`](dotfiles/.config/feh/keys)
- [`polybar/config`](dotfiles/.config/polybar/config)
- [`.zshrc`](dotfiles/.zshrc)
- [`userChrome.css`](etc/userChrome.css) - A bare-minimum browser that emphasizes keyboard usage
- [`user.js`](etc/user.js) - Settings to make using the browser a more pleasurable experience

### Install Scripts

The install scripts let you install the entire operating system and dotfiles with a simple command. Note that you should not run this on your actual computer. The install script is meant to be used with the Arch ISO. Simply run:

```bash
wget https://raw.githubusercontent.com/GloverDonovan/new-start/master/install/install.sh
chmod +x install.sh
./install.sh
```

Some of the software I use include (in no particular order): [neovim](https://github.com/neovim/neovim), [ranger](https://github.com/ranger/ranger), [feh](https://github.com/derf/feh), [mpv](https://github.com/mpv-player/mpv), [zathura](https://github.com/pwmt/zathura), [yay](https://github.com/Jguer/yay), [compton](https://github.com/chjj/compton), [polybar](https://github.com/jaagr/polybar), [termite](https://github.com/thestinger/termite), [shotgun](https://github.com/Streetwalrus/shotgun), [waterfox](https://github.com/MrAlex94/Waterfox), [inox](https://github.com/gcarq/inox-patchset), [cmus](https://github.com/cmus/cmus), [i3-gaps](https://github.com/Airblader/i3), and [zsh](https://wiki.archlinux.org/index.php/Zsh).

For a complete list of the packages included, see [`install/packages.sh`](install/packages.sh) and [`install/aur.sh`](install/aur.sh).

**NOTE**: The install script is incomplete and should not be used (yet)!

After installation, you will be able to use the operating system and even put it on a live USB!

### Help Files

Help files are a way for me to keep track of all the useful commands I learn about certain software. They're compiled in easy-to-read files so I don't have to search the same thing over and over.

- [`commands.md`](help/commands.md) - The majority of terminal commands I use on a daily basis
- [`git.md`](help/git.md) - There's a lot more to Git than you think (no pun intended)
- [`gpg.md`](help/gpg.md) - Everything you need to know about GPG
- [`profanity.md`](help/profanity.md) - A primer on using XMPP with Profanity
- [`vim.md`](help/vim.md) - A complete reference to everything I know (and find worth mentioning) about vim

### Custom Software

This directory holds custom software that I made specifically for my use case. Feel free to use them for inspiration.

Some of the most interesting software include:

- [`maid.cr`](src/maid.cr) - An easy way to manage dotfiles.
- [`theme.cr`](src/theme.cr) - Easily change color schemes across everything, including polybar, termite, and i3. Uses `base16` color schemes.

Run `crystal docs` to generate the documentation for these files in a nice format.

## Contributing

If you want to improve the help files or other parts of New Start then please file an issue first. Pull requests are accepted, but I'd prefer if you made an issue first!

## License

- Code is released under the GPLv3 license.
- Help files are released under the Creative Commons BY-SA license.
