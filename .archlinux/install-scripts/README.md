# Install Scripts

Here are my Arch Linux install scripts. They are divided into 4 parts:

1. Pre-install: Setting up the drive to install Arch on
2. Install: Installing Arch Linux to that drive
3. Configure: Writing some basic low-level config files
4. Post-install: Post-install configuration

I have one `install.sh` script that calls the first three scripts with the proper settings. The fourth script should be ran after a reboot. (TODO: Probably easier to run a subset of post-install commands in the installation media, + internet will already be covered, which allows us to clone this repository to the newly created home directory and run any other post-install commands on first boot... may also be useful to divide the install scripts a bit further to support more options).

> **Note**: If you do not understand my install scripts, you should follow the [Installation guide][archguide] instead.

## Setup

> TODO...

[archguide]: https://wiki.archlinux.org/index.php/Installation_guide
