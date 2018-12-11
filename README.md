# ~/.files

> TODO: Screenshots

## What is an operating system?

An operating system is a collection of software. Every operating system builds off of the work of many other individuals and their respective creations (the "software"). This is how systems work, and is not unique to operating systems nor computing itself.

[GNU/Linux][gnulinux] is a collection of software that most modern free operating systems use. Note that a significant amount of non-GNU/Linux software, such as systemd, Xorg, and other software, is used to make a complete GNU/Linux distribution.

## Usage

### Replicate my [Arch Linux](/.archlinux) setup

Note that if you already have an Arch Linux install and just want my look, you can simply install the necessary software and use my dotfiles with them.

On a fresh [Arch Linux][archlinux] install, run the bootstrap script.

```sh
git clone https://github.com/GloverDonovan/.files --depth 1 && ./.files/.archlinux/bootstrap.sh
```

> **Note**: My [install scripts](./.archlinux/install-scripts) may be of use to you, but remember to add what you need and change what you don't want as needed.

### Replicate my [Fedora](/.fedora) setup

On a fresh [Fedora][fedora] install, run the bootstrap script.

```sh
git clone https://github.com/GloverDonovan/.files --depth 1 && ./.files/.fedora/bootstrap.sh
```

> **Note**: If you just want my Fedora look, run the [make rice](./.fedora) target.

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

## Making changes

To change the settings used by a certain program, simply edit the necessary dotfiles for that program.

### Arch Linux

To change how the Arch Linux installation process works, simply edit the files in `.archlinux` before you run `bootstrap.sh`.

If you want to use [Tari](./.archlinux/PKGBUILDs) but don't want to use all the packages, simply remove the lines of packages that you don't need in the `PKGBUILD` before installing it.

### Fedora

To change how the Fedora installation process works, simply edit the files in `.fedora` before you run `bootstrap.sh`.

## Updating

To update your system with any changes I make, you must first verify that the changes I made are actually changes you want. Eventually I want to consider my dotfiles "stable" (i.e. 1.0.0, 2.0.0, etc.) in which only major version upgrades would significantly alter existing functionality, but right now this simply isn't the case.

Once you've verified that you indeed want my changes, update your local copy of the repository like so:

```sh
git pull
```

If you don't want changes straight from master, and instead want to update incrementally, checkout the version tag you want, like so:

```sh
git checkout 0.2.0
```

If you used the stow method, all of the dotfiles that you use from me will already be updated; you do not have to do anything else. If git tells you that there are conflicts, you probably want to rebase your changes on top of mine, or consider making your own version of those files instead.

## Downgrading

If for some reason you updated by accident and want existing functionality back, you can simply checkout a previous version or commit.

For example, if your configuration was last known to work at commit `a1b2c3d`, you would use:

```sh
git checkout a1b2c3d
```

[archlinux]:  https://www.archlinux.org
[fedora]:     https://getfedora.org
[gnulinux]:   https://www.gnu.org/gnu/linux-and-gnu.html
[freesw]:     https://www.gnu.org/philosophy/free-sw.html
[stow]:       https://www.gnu.org/software/stow/manual/stow.html
