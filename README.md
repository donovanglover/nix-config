# Dotfiles

> TODO: Screenshots

## Usage

### Replicate my [Fedora setup](/.fedora)

On a fresh [Fedora][fedora] install, run the bootstrap script.

```sh
git clone https://github.com/GloverDonovan/dotfiles --depth 1 && ./dotfiles/.fedora/bootstrap.sh
```

### Replicate my [Arch setup](/.arch)

On a fresh [Arch Linux][archlinux] install, run the bootstrap script.

```sh
git clone https:///github.com/GloverDonovan/dotfiles --depth 1 && ./dotfiles/.archlinux/bootstrap.sh
```

### Use only the dotfiles you want

Install [stow][stow] with `pacman -S stow` (Arch Linux) or `dnf install stow` (Fedora). Other [GNU/Linux](gnulinux) distributions will also work, but aren't officially supported.

Use `make package=<dir>` and `make uninstall package=<dir>` as needed to install and uninstall dotfiles. Stow only changes what it owns, so you do not have to worry about existing dotfiles being changed.

[archlinux]:  https://www.archlinux.org
[fedora]:     https://getfedora.org
[gnulinux]:   https://www.gnu.org/gnu/linux-and-gnu.html
[freesw]:     https://www.gnu.org/philosophy/free-sw.html
[stow]:       https://www.gnu.org/software/stow/manual/stow.html
