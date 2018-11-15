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

Install [`stow`][stow] with your package manager, then use `make package=dir` and `make uninstall package=dir` as needed. Stow will only change what it owns.

[archlinux]:  https://www.archlinux.org
[fedora]:     https://getfedora.org
[gnulinux]:   https://www.gnu.org/gnu/linux-and-gnu.html
[freesw]:     https://www.gnu.org/philosophy/free-sw.html
[stow]:       https://www.gnu.org/software/stow/manual/stow.html
