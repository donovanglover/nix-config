# Dotfiles

> TODO: Screenshots

## Usage

### Replicate my [Arch Linux](/.archlinux) setup

On a fresh [Arch Linux][archlinux] install, run the bootstrap script.

```sh
git clone https:///github.com/GloverDonovan/dotfiles --depth 1 && ./dotfiles/.archlinux/bootstrap.sh
```

### Replicate my [Fedora](/.fedora) setup

On a fresh [Fedora][fedora] install, run the bootstrap script.

```sh
git clone https://github.com/GloverDonovan/dotfiles --depth 1 && ./dotfiles/.fedora/bootstrap.sh
```

### Use only the dotfiles you want

#### Method 1. With [`stow`][stow]

First, install stow with your package manager. Then, run the following:

```sh
make package=kitty
```

This will symlink my kitty config to your `$XDG_CONFIG_HOME`. If you want to install a different package, simply replace `kitty` with the name of the directory you wish to get dotfiles from.

Since `stow` will only change what it owns, you do not have to worry about any of your existing dotfiles being changed when you use this method.

To uninstall packages, simply use:

```sh
make uninstall package=kitty
```

This will remove the symlink to my kitty config. If you have other kitty files, stow will not remove them, since stow only changes what it owns.

#### Method 2. Manually

If you already have dotfiles and want to improve them, you can use this repository as a guide. If you find something that makes your dotfiles better, you're free to use it.

If you don't want to use stow, you can simply copy/paste the dotfiles you want to their relevant directories.

[archlinux]:  https://www.archlinux.org
[fedora]:     https://getfedora.org
[gnulinux]:   https://www.gnu.org/gnu/linux-and-gnu.html
[freesw]:     https://www.gnu.org/philosophy/free-sw.html
[stow]:       https://www.gnu.org/software/stow/manual/stow.html
