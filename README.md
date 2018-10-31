# Dotfiles

> TODO: Screenshots

## Usage

### Step 0. Clone this repository

Add `--depth 1` to only fetch the latest commit.

```sh
git clone https://github.com/GloverDonovan/dotfiles.git --depth 1
```

### Step 1. Install [stow][stow]

- [Arch Linux][archlinux]: `pacman -S stow`
- [Fedora][fedora]: `dnf install stow`

### Step 2. Install the dotfiles you want

For example, to use my vim config, run:

```sh
make package=vim
```

Since my dotfiles are managed with Stow, any of your existing dotfiles will not be overridden or changed.

## List of dotfiles

- [bspwm](/bspwm) - All the config files relating to my window manager setup.
- [code](/code) - My config for Code, a reasonable editor for non-vim users.
- [editorconfig](/editorconfig) - Spaces or tabs? Just use `.editorconfig`.
- [extras](/extras) - A collection of miscellaneous other dotfiles I use.
- [fish](/fish) - My settings for fish, the friendly interactive shell.
- [git](/git) - The standard version control tool.
- [gpg](/gpg) - My settings for GPG.
- [plasma](/plasma) - Dotfiles specific to KDE Plasma.
- [systemd](/systemd) - User services, such as ssh-agent and urxvtd.
- [tmux](/tmux) - A vim-like terminal multiplexer that gets out of your way.
- [vim](/vim) - The settings I use for vim, also known as the best editor.
- [xmodmap](/xmodmap) - Make caps lock function as ctrl and escape.

## Uninstall

If you don't want to use some of my dotfiles anymore, they can be easily uninstalled. For example, if you don't want to use my `.vimrc` anymore, run:

```sh
make uninstall package=vim
```

This will only remove the files that Stow owns, while keeping your other files intact.

[archlinux]:  https://www.archlinux.org
[fedora]:     https://getfedora.org
[gnulinux]:   https://www.gnu.org/gnu/linux-and-gnu.html
[freesw]:     https://www.gnu.org/philosophy/free-sw.html
[stow]:       https://www.gnu.org/software/stow/manual/stow.html
