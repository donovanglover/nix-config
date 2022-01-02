# Muya - A light rice for Fedora

> NOTE: As of 2022, none of my machines run Fedora, so this may need some modifications to get working correctly.

This is my setup for [Fedora][fedora], a [GNU/Linux][gnulinux] distribution that ships with GNOME by default, making it an ideal choice for most users. This guide covers a *simple* rice that will make your Fedora look much nicer than the defaults. It only uses packages from the official repositories, making it quick and easy to set up on any machine.

> This guide will work with the **latest version** of Fedora (29 as of this writing).

## Use my GNOME theme and settings

To copy the look and feel of my GNOME setup, run:

```sh
make rice
```

That's it! You now have a very simple Fedora rice.

## Use my packages and scripts

### Install kitty

Use `make kitty` to install the [kitty](/kitty) terminal emulator.

### Install wal

Use `make wal` to install [pywal](/wal).

### Install crystal

Use `make crystal` to install the [Crystal][crystal] programming language.

### Install rustup

Use `make rustup` to install the Rust toolchain installer.

## Mimic my entire setup

If you want to use *everything* I use, simply run the bootstrap script, like so:

```sh
./bootstrap.sh
```

The script will ask for sudo permissions the first time you run it. Then you can sit back and relax as no manual intervention is necessary.

[fedora]: https://getfedora.org
[gnulinux]: https://www.gnu.org/gnu/linux-and-gnu.html
[crystal]: https://crystal-lang.org/
