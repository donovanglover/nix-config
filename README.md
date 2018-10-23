# Dotfiles

> TODO: Screenshots

## Usage

### Step 1. Install `stow`

- Arch Linux: `pacman -S stow`
- Fedora: `dnf install stow`

If you are using a different [GNU/Linux][gnulinux] operating system, most
(if not all) of the files should work, but I will not provide support for
those distributions.

If you are using a [non-free][freesw] operating system, I recommend
[Fedora][fedora]. If you want to mimic my bspwm setup, you probably want
[Arch Linux][archlinux] instead.

### Step 2. Install the dotfiles you want

For example, to use my vim config, run:

```shell
make package=vim
```

None of your dotfiles will be overridden. If you already have a `.vimrc`,
stow will not override it. The same rule applies for any dotfiles you try
to install.

## List of dotfiles

- [bspwm](/bspwm) - All the config files relating to my window manager setup.
- [code](/code) - My config for Code, a reasonable editor for non-vim users.
- [editorconfig](/editorconfig) - Spaces or tabs? Just use `.editorconfig`.
- [extras](/extras) - A collection of miscellaneous other dotfiles I use.
- [fish](/fish) - My settings for fish, the friendly interactive shell.
- [git](/git) - The standard version control tool.
- [gpg](/gpg) - My settings for GPG.
- [plasma](/plasma) - Dofiles specific to KDE Plasma.
- [systemd](/systemd) - User services, such as ssh-agent and urxvtc.
- [term](/term) - Config for urxvt and termite. May apply elsewhere as well.
- [tmux](/tmux) - A vim-like terminal multiplexer that gets out of your way.
- [vim](/vim) - The settings I use for vim, also known as the best editor.
- [wal](/wal) - My additions to wal's color scheme application algorithm.
- [xmodmap](/xmodmap) - Make caps lock function as ctrl and escape.

## Uninstall

If you don't want to use some of my dotfiles anymore, they can be easily
uninstalled without removing any of your other files.

For example, if you don't want to use my `.vimrc` anymore, run:

```
make uninstall package=vim
```

This will remove only my vim files from your system, while keeping your other
files intact. Stow will only remove what it owns.

[archlinux]:  https://www.archlinux.org
[fedora]:     https://getfedora.org
[gnulinux]:   https://www.gnu.org/gnu/linux-and-gnu.html
[freesw]:     https://www.gnu.org/philosophy/free-sw.html
[stow]:       https://www.gnu.org/software/stow/manual/stow.html
