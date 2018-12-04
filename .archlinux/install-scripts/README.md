# Install Scripts

Here are my Arch Linux install scripts. They are divided into 4 parts:

1. Pre-install: Setting up the drive to install Arch on
2. Install: Installing Arch Linux to that drive
3. Configure: Writing some basic low-level config files
4. Post-install: Post-install configuration

I use `install.sh` to call these scripts with the proper user-generated variables. (TODO: clone this repository to the newly created home directory and run any other post-install commands on first boot).

> **Note**: If you do not understand my install scripts, you should follow the [Installation guide][archguide] instead.

## Usage

First, download the .files archive, like so:

```sh
wget https://github.com/GloverDonovan/.files/archive/master.zip
```

Then, install `unzip` and unzip the archive. Note that `-Sy` is used here since you don't want to update *everything* on the installation media, and `unzip` is unlikely to break in this case.

```sh
pacman -Sy unzip --noconfirm
unzip master.zip
```

Finally, run the install script:

```sh
./.files-master/.archlinux/install-scripts/install.sh
```

[archguide]: https://wiki.archlinux.org/index.php/Installation_guide
