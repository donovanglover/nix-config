# New Start

> Vim is my editor, \*nix is my IDE.

TODO: Put images here

## Table of Contents

- [A Brief History](#a-brief-history)
- [Design Goals](#design-goals)
- [Usability Goals](#usability-goals)
- [Getting Started](#getting-started)
- [Contributing](#contributing)

## A Brief History

Some important things to note:

1. Linux is not an operating system. It is simply a kernel used as part of an operating system. All the so-called Linux distributions are actually distributions of GNU/Linux.
2. Arch is rolling release. You will always have the latest software. There is no such thing as "updating to the next version of Arch".
3. Keep it simple. At the end of the day, you only need to use your computer for a few specific tasks, such as listening to music, writing software, sending messages, and using the internet.
4. You have complete control over your software. There is no need to insult your computer. If something doesn't work, it's more often than not user error.

## Getting Started

Stuff you may want:

- `app/` - All the files used to run my local server
- `dotfiles/` - All the dotfiles used to configure the system
- `etc/` - Other config files that don't exactly have definite paths
    - `userChrome.css` - A bare-minimum browser that emphasizes keyboard usage
- `grub/` - A nice theme for grub
- `help/` - All the important things I want to remember when using my system
    - `vim.md` - A complete reference to everything I know (and find worth mentioning) about vim
- `src/` - Small programs I use to handle my specific needs

Summary of the other directories:

- `bin/` - Output directory for compiled binaries from `src`
- `docs/` - Output directory for compiled documentation from `src`
- `external/` - Also known as "not my files", these files reside in the external directory so they don't count towards GitHub's language algorithm
- `install/` - Scripts to automate installing the system with the Arch ISO
    - `packages.sh` - All of the packages I use (and why) from the official repos
- `lib/` - Output directory for the libraries used by `src`
- `spec/` - Tests for the files in `src` to make sure that nothing breaks

## Design Goals

1. **Simplicity.** It should be trivial to find and edit the things you're looking for; to get things done. Once mastered, the interface should not get in the way.
2. **Reproducability.** It should be trivial to reproduce your previous environment from a fresh install.
3. **Universality.** All functionality should be handled through the terminal.

## Usability Goals

1. **Configuration is self-documenting.** It is trivial for someone to view and understand how the dotfiles work.
2. **Everything just works.** The configuration is simple enough that the possibility for edge cases are extremely limited.

The default wallpaper is [Arch Adapta](https://www.reddit.com/r/UnixWallpapers/comments/71lcxo/). The [original](https://github.com/adapta-project/adapta-backgrounds) was made by [Tista](https://github.com/tista500) and is released under the [Creative Commons Share-Alike 3.0](https://creativecommons.org/licenses/by-sa/3.0/) license.

By default I keep track of the many useful commands and other features I use on a daily basis. Please not that these are not a replacement for reading the man pages of said software.

One thing that always annoyed me was viewing the dotfiles of other people. Many people leave all the default settings in their dotfiles, when the same exact settings are going to be sourced anyway before calling the config file. Your dotfiles should only have what you're changing and nothing else.

## Contributing
