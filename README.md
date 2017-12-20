# New Start

> Vim is my editor, \*nix is my IDE.

TODO: Put images here

New Start is built on top of [Arch GNU/Linux](https://www.archlinux.org/) and consists of my [dotfiles](dotfiles/), [install scripts](install/), [help files](help/), and [custom software](src/).

## Before You Begin

1. [Linux is not an operating system](https://www.gnu.org/gnu/linux-and-gnu.html). It is simply a kernel used as part of an operating system. Do not say that you use "Linux"; rather, you use the GNU system with Linux, or GNU plus Linux. All the so-called Linux distributions are actually distributions of GNU/Linux.
2. [Arch GNU/Linux is rolling-release](https://wiki.archlinux.org/index.php/Arch_Linux). You will always have the latest software. There is no such thing as having to install a new version of Arch.
3. [Free software gives you complete control over your computing](https://www.gnu.org/philosophy/free-sw.html). If something doesn't work, it's more often than not user error. You no longer have the luxury of blaming your computer for "not working".
4. [Keep it simple](https://en.wikipedia.org/wiki/KISS_principle). At the end of the day, you only need to use your computer for a few specific tasks, such as listening to music, writing software, sending messages, and using the internet. Don't overcomplicate things.

## Design Goals

1. **Simplicity.** It should be trivial to find and edit the things you're looking for; to get things done. Once mastered, the interface should not get in the way. Everything just works.
2. **Reproducability.** It should be trivial to reproduce your previous environment from a fresh install.
3. **Universality.** Interaction with the system should be consistent, using similar keybindings, fonts, and looks. Using the terminal as opposed to click-point windows allow for minimum configuration and maximum universality.

## Getting Started

I did my best to make the configuration self-documenting. You should be able to go through the files and understand how they work.

- `app/` - All the files used to run my local server
- `dotfiles/` - All the dotfiles used to configure the system
- `etc/` - Other config files that don't exactly have definite paths
    - [`userChrome.css`](etc/userChrome.css) - A bare-minimum browser that emphasizes keyboard usage
- `grub/` - A nice theme for grub
- `help/` - All the important things I want to remember when using my system
    - [`vim.md`](help/vim.md) - A complete reference to everything I know (and find worth mentioning) about vim
- `src/` - Small programs I use to handle my specific needs

Summary of the other directories:

- `bin/` - Output directory for compiled binaries from `src`
- `docs/` - Output directory for compiled documentation from `src`
- `external/` - Also known as "not my files", these files reside in the external directory so they don't count towards GitHub's language algorithm
- `install/` - Scripts to automate installing the system with the Arch ISO
    - `packages.sh` - All of the packages I use (and why) from the official repos
- `lib/` - Output directory for the libraries used by `src`
- `spec/` - Tests for the files in `src` to make sure that nothing breaks

## Contributing

This is a big project; I may have let some things slip through such as typos or other errors. If you want to improve the help files or other parts of the project then please file an issue first. Pull requests are accepted, but I'd prefer if you made an issue first!
