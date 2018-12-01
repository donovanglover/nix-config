# PKGBUILDs

Here are my PKGBUILDs I use on Arch Linux. Each has a specific use case. I use PKGBUILDs to know exactly what I have on my machine, and to make it easier to sync changes across multiple Arch installations.

Of course, you don't have to use **any** of these packages for your own installation, but if you want to use my setup, you probably want to use the packages I use as well.

## Getting Started

There are some **core packages** that need to be installed before anything else, listed below:

- [tari-core](/.archlinux/PKGBUILDs/tari-core) - Core packages I use for many things
- [tari-cli](/.archlinux/PKGBUILDs/tari-cli) - CLI programs that are nice to have
- [tari-desktop](/.archlinux/PKGBUILDs/tari-desktop) - Packages I use common to all desktop environments

### Add-on packages

Now that everything is installed, it's just a matter of choosing a desktop environment or window manager. Note that you can install multiple DEs and WMs at once, then switch between them with your display manager.

- [tari-gnome](/.archlinux/PKGBUILDs/tari-gnome) - The GNOME desktop environment, with GTK-related software
- [tari-plasma](/.archlinux/PKGBUILDs/tari-plasma) - The Plasma desktop environment, with Qt and KDE-related software
- [tari-bspwm](/.archlinux/PKGBUILDs/tari-bspwm) - The bspwm window manager, with optional Qt and GTK support (through `tari-gnome` and `tari-plasma`)

Other window managers exist, but may not be trivial to use in non-traditional (HiDPI) environments.

### Other packages

- [tari-scripts](/.archlinux/PKGBUILDs/tari-scripts) - Color scripts, purely for aesthetics
- [tari-util-xeventbind](/.archlinux/PKGBUILDs/tari-util-xeventbind) - Useful to change X DPI on resolution change

TODO: More to come soon...
