# New Start

> Vim is my editor, \*nix is my IDE.

TODO: Put images here

New Start is built on top of [Arch GNU/Linux](https://www.archlinux.org/) and consists of my [dotfiles](dotfiles/), [install scripts](install/), [help files](help/), and [custom software](src/).

New start strives for simplicity, reproducability, and universaltiy. More specifically,

**Simplicity.** It should be trivial to find and edit the things you're looking for; to get things done. Once mastered, the interface should not get in the way. Everything just works.

**Reproducability.** It should be trivial to reproduce your previous environment from a fresh install.

**Universality.** Interaction with the system should be consistent, using similar keybindings, fonts, and looks. Using the terminal as opposed to click-point windows allow for minimum configuration and maximum universality.

## Before You Begin

These are some important things I believe any potential user of New Start should know.

1. [Linux is not an operating system](https://www.gnu.org/gnu/linux-and-gnu.html). It is simply a kernel used as part of an operating system. Do not say that you use "Linux"; rather, you use the GNU system with Linux, or GNU plus Linux. All the so-called Linux distributions are actually distributions of GNU/Linux.
2. [Arch GNU/Linux is rolling-release](https://wiki.archlinux.org/index.php/Arch_Linux). You will always have the latest software. There is no such thing as having to install a new version of Arch.
3. [Free software gives you complete control over your computing](https://www.gnu.org/philosophy/free-sw.html). If something doesn't work, it's more often than not user error. You no longer have the luxury of blaming your computer for "not working".
4. [Keep it simple](https://en.wikipedia.org/wiki/KISS_principle). At the end of the day, you only need to use your computer for a few specific tasks, such as listening to music, writing software, sending messages, and using the internet. Don't overcomplicate things.

## Getting Started

### app/

The views for my local server end up here.

#### views

- [`index.ecr`](app/views/index.ecr) - Simple home page, clean and elegant

### dotfiles/

I know how frustrating it is to see a setup and not have access to the dotfiles. I also know how frustrating it is to go through dotfiles with default config settings everywhere or dotfiles with little to no documentation at all.

My goal here is simple: use as few config settings as possible required to make everything work, and document the settings that I do use. Your "config" file shouldn't be a `man` page!

- [`cmus/rc`](dotfiles/.config/cmus/rc)
- [`fontconfig/fonts.conf`](dotfiles/.config/fontconfig/fonts.conf)
- [`feh/keys`](dotfiles/.config/feh/keys)
- [`gtk-3.0/gtk.css`](dotfiles/.config/gtk-3.0/gtk.css)
- cmus/
    - [`input.conf`](dotfiles/.config/mpv/input.conf)
    - [`mpv.conf`](dotfiles/.config/mpv/mpv.conf)
- polybar/
    - [`config`](dotfiles/.config/polybar/config)
    - [`cmus.sh`](dotfiles/.config/polybar/cmus.sh)
    - [`launch.sh`](dotfiles/.config/polybar/launch.sh)
- [`.zshrc`](dotfiles/.zshrc)
- [`.zsh_aliases`](dotfiles/.zsh_aliases)
- [`.zsh_functions`](dotfiles/.zsh_functions)
- [`.zprofile`](dotfiles/.zprofile)
- [`.ctags`](dotfiles/.ctags)
- [`.dircolors`](dotfiles/.dircolors)
- [`.mailcap`](dotfiles/.mailcap)
- [`.tmux.conf`](dotfiles/.tmux.conf)
- [`.xmodmap`](dotfiles/.xmodmap)

### etc/

All config files that don't have definite paths in `~` end up here.

- [`userChrome.css`](etc/userChrome.css) - A bare-minimum browser that emphasizes keyboard usage
- [`user.js`](etc/user.js) - Settings to make using the browser a more pleasurable experience

### help/

Help files are a way for me to keep track of all the useful commands I learn about certain software. They're compiled in easy-to-read files so I don't have to search the same thing over and over.

- [`commands.md`](help/commands.md) - The majority of terminal commands I use on a daily basis
- [`git.md`](help/git.md) - There's a lot more to Git than you think (no pun intended)
- [`gpg.md`](help/gpg.md) - Everything you need to know about GPG
- [`profanity.md`](help/profanity.md) - A primer on using XMPP with Profanity
- [`vim.md`](help/vim.md) - A complete reference to everything I know (and find worth mentioning) about vim

### src/

This directory holds custom software that I made specifically for my use case. Feel free to use them for inspiration.

- [`git-blame.cr`](src/git-blame.cr) - A colorful version of `git blame`
- [`maid.cr`](src/maid.cr) - This program is in charge of managing all my dotfiles
- [`mktex.cr`](src/mktex.cr) - This program handles compiling my LaTeX files into PDF papers. It keeps intermediary files in a separate directory from everything else
- [`pass.cr`](src/pass.cr) - A simple password manager
- [`server.cr`](src/server.cr) - Handles the logic behind my local server
- [`theme.cr`](src/theme.cr) - Easily change color schemes across everything, including polybar, termite, and open terminal windows. Support for base16 color schemes as well as custom color schemes

Note that you should run `crystal docs` in the root directory if you want to view the documentation for these files in a nice format.

### Other Directories

The other directories may not be as interesting to go through, but each one has a purpose.

- `bin/` - Output directory for compiled binaries from `src`
- `docs/` - Output directory for compiled documentation from `src`
- `external/` - Also known as "not my files", these files reside in the external directory so they don't count towards GitHub's language algorithm
- `grub/` - A nice theme for grub
- `install/` - Scripts to automate installing the system with the Arch ISO
    - `packages.sh` - All of the packages I use (and why) from the official repos
- `lib/` - Output directory for the libraries used by `src`
- `spec/` - Tests for the files in `src` to make sure that nothing breaks

## Contributing

This is a big project; I may have let some things slip through such as typos or other errors. If you want to improve the help files or other parts of the project then please file an issue first. Pull requests are accepted, but I'd prefer if you made an issue first!

[Many users mistakenly use "Linux" without knowing that they're actually using GNU](https://www.gnu.org/gnu/gnu-users-never-heard-of-gnu.html). I was a victim of this. I used a variety of "Linux" distributions in the past and had no idea what a "GNU" even was. Please help spread the word about the GNU Project.

[Free software is more than just gratis](#). We need to educate our population about free software. A lot of the software I preferred to use in the past was free software yet I never understood the true meaning of "free software" nor the philosophy behind it.
