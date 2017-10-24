# Simplicity. Minimalism. Elegance.

> A modern Arch workflow built with an emphasis on functionality.

TODO: Put images here

## Table of Contents

- [Philosophy](#philosophy)
    - [GNU/Linux](#gnulinux)
    - [Arch Linux](#arch-linux)
	- [Design Goals](#design-goals)
	- [Usability Goals](#usability-goals)
    - [Use Case](#use-case)
- [Features](#features)
- [Installation](#installation)
    - [Installing From Source](#installing-from-source)
    - [Using a Pre-Compiled Image](#using-a-pre-compiled-image)
- [Post-Installation](#post-installation)
- [Workflow](#workflow)
- [Help](#help)
- [Contributing](#contributing) 

## Philosophy

> Create your own system, tailored to your specific needs. Make GNU/Linux work for you. 

Often as end-users we come across a variety of roadblocks that prevent us from doing what we want to get done. "If only this program could do X" or "if only my operating system was better at handling Y". **Proprietary software** forces us to accept whatever inconveniences we face as a matter of fact. We will have to deal with these inconveniences until the upstream developers decide to do something with it. **Proprietary software** may also change at any time, forcing the end-user to conform to new practices whether they like it or not. **Free software**, on the other hand, allow us to have complete control of our computers. If something doesn't work, we can fix it. If we want to change something, we can change it. We're not waiting for or trusting anyone else to do it. We have the power to change the things we don't like and redistribute them for others to use.

**Free software** promotes innovation. How? Anyone is allowed to contribute to the upstream project. If someone doesn't agree with the direction a piece of software is going, they have the freedom to modify the software and redistrbute those modifications to the community. If a particular piece of software goes downstream or starts promoting malicious activities, it is easy and trivial for users to switch to the modified software. **Free software** is a competitive environment decided by the people. Vendor lock-in is limited; if your software doesn't conform to the user's wants--the user's needs, another piece of software will.

Do not confuse **free software** with **freeware**. **Freeware** is any piece of software that is distributed with no price; however, **freeware** is **not** *free software*. **Free software**, in comparison, **may** come with a price. **Free software** in this context refers to the **freedom** to do anything with the software you obtain, whether you have to pay for it or not.

Compare this to **proprietary software**, which often impose restrictions on how you can use the software *even after you purchase it*. Legally speaking, your rights to the software are restricted before you even decide to buy it. If you don't like something and want to change it, you're not able to, even if you paid for it.

Formally, we say that a software $S$ is **free software** if and only if:

1. You have the freedom to use the software as you wish, for any purpose.
2. You have the freedom to study how the program works, and change it so the program works for you and not the other way around.
3. You have the freedom to redistribute copies of the software, similar to sharing your music with a friend, but with software.
4. You have the freedom to distribute modified versions of the software to others. This makes it possible for everyone else to benefit from your changes. 

A software that does not adhere to the above conditions is said to be **nonfree software**. **Nonfree software** includes **freeware**, that is, software offered at no price but does not grant the four freedoms.

It is important to note that **open source software** is **not** **free software**. Anyone can publish their code online. This code is still limited by the terms set forth in the **software license**.

TODO: Rewrite next few paragraphs

Freedom is a powerful thing. You don't realize what you don't have. But when you have it, you never want to lose it. Freedom works the same way. Once you experience the freedom of being able to change any part of your system, at any time and for any reason, without anyone or anything else restricting you otherwise, you start to wonder how you ever managed without such freedoms.

The age-old saying still goes: with great power comes great responsibility. You aren't hindered by any external limits; only yourself. There are no handlebars. Anything you do is done. You are responsible for your own software. You have complete control.

### GNU/Linux

**Linux** is not an operating system; it is merely a popular kernel that people use *in* their operating systems.

TODO

### Arch Linux

Using Arch for the base of the operating system allows us to control exactly what we put in our system.

1. Arch is a rolling-release operating system. You will typically have the latest and greatest of all available software.
2. Only build what you need. Arch does not ship with unnecessary programs or other bloat that you do not use.
3. Keep it simple. At the end of the day, we only need to use our computers for a few specific tasks, such as listening to music, writing software, sending messages, and using the internet.
4. Centralized yet decentralized. The Arch repository makes it trivial to update packages.
5. Customization. You're able to change and customize pretty much anything you can think of (well, that is, unless you're using proprietary software). You can write programs to change and modify any part of your operating system. This is how TeX was born and is at the core of hacking culture. You have complete control of your software.

TODO

### Design Goals

1. **Simplicity.** It should be trivial to find and edit the things you're looking for.
2. **Reproducability.** It should be trivial to reconfigure all of your settings from a fresh install.
3. **Minimal.** It should only have what you need and nothing else.

### Usability Goals

1. **Everything just works.** There is no need to configure anything. You simply go through the installation and you're looking at an identical workspace as before.
2. **Automation.** Important things like making backups and cleaning up should be automatic.
3. **Virtualization.** It should be trivial to setup a fresh working environment in a brand new virtual machine.

NOTE: In the future, I may make it easier to use custom configurations (such as automatically fetching your dotfiles from a git repository). As it stands now, this repository is completely centric on my own personal configuration and does not aim to replicate other people's dotfiles or other configuration. This should be trivial to setup with a minor inconvenience to me.

TODO: Add this somewhere:

**Configuration is self-documenting.** It is trivial for someone to view and understand how the dotfiles work.

### Use Case

TODO

## Installation

Installation aims to be as simple as possible. It should be trivial to have a working system environment with as little effort as possible. You can build the environment from scratch or use a pre-configured iso.

The following assumptions are made:

1. You use the US keyboard layout. (A default in Arch Linux)
2. Your timezone is Eastern Time. (You can easily change this in the script)
3. You have secure boot disabled (Secure boot may prevent the computer from booting free software)

TODO: Make it trivial for people to change timezone / keyboard layout / etc. without manually changing the script

NOTE: Testing non-US keyboard layouts is not within my scope and would need to be done by someone else (I have no experience with how Arch handles other keyboards)

### Installing From Source

**Important:** Do *not* attempt to run this script on your physical machine. This script was made for and has only been tested in a fresh new virtual machine running the Arch Linux ISO.

Boot into the Arch Linux ISO. Then, run the following commands:

```
wget https://raw.githubusercontent.com/GloverDonovan/new-start/master/install.sh
chmod +x install.sh
./install.sh <HOSTNAME> <LOCALUSER>
```

Replace `<HOSTNAME>` with your preferred hostname and `<LOCALUSER>` with the name of the user account to create.

## Post-Installation

The default login information is username/username.

1. Change the root password with `passwd`
2. Change the local account password with `passwd <username>`

That's it! You're now ready to use your shiny new system!

## Workflow

> Vim is my editor, \*nix is my IDE.

TODO

### Core Software

These are the software that you interact with on a daily basis. They are a bit more complex than commands.

- Editor: [vim](https://github.com/vim/vim)
- File Browser: [ranger](https://github.com/ranger/ranger)
- Image Viewer: [feh](https://github.com/derf/feh)
- Video Player: [mpv](https://github.com/mpv-player/mpv)
- Music Player: [cmus](https://github.com/cmus/cmus)
- Web Browser:
	1. [inox](https://github.com/gcarq/inox-patchset) (Chromium patch)
	2. [waterfox](https://github.com/MrAlex94/Waterfox) (Firefox fork)

### Supporting Software

These are the software that you don't "interact with" per-se (i.e. you don't run the command) but are an essential part of the operating system nonetheless.

- Display Server: [xorg](https://wiki.archlinux.org/index.php/Xorg)
- Shell: [zsh](https://wiki.archlinux.org/index.php/Zsh)
- Window Manager: [i3-gaps](https://github.com/Airblader/i3)
- Display Manager: TODO - I haven't decided on a display manager yet, most of them are *too* graphical. I'm looking for a simple DM that emphasizes keyboard usage
- Terminal Emulator: [termite](https://github.com/thestinger/termite)
- Information System: [polybar](https://github.com/jaagr/polybar)
- Lock Screen: i3lock
- Compositor: [compton](https://github.com/chjj/compton)
- AUR Helper: [pacaur](https://github.com/rmarquis/pacaur)
- Screenshot: [shotgun](https://github.com/Streetwalrus/shotgun)
- Color Scheme: [base16](https://github.com/chriskempson/base16)
    - [shell](https://github.com/chriskempson/base16-shell)
    - [vim](https://github.com/chriskempson/base16-vim)
    - TODO: Consider the most important information to output in trufetch (base16 theme, etc.)
- Boot Loader: [grub](https://wiki.archlinux.org/index.php/GRUB)
- GRUB Theme: [arch-silence](https://github.com/fghibellini/arch-silence)

TODO: Differentiate between color scheme and theme

### Browser Software

- Content Blocker: [uBlock Origin](https://github.com/gorhill/uBlock)
- Vim Keybindings: [VimFx](https://github.com/akhodakivskiy/VimFx), [Vimium](https://github.com/philc/vimium)
- Secure Connection: [HTTPS Everywhere](https://github.com/EFForg/https-everywhere)

### Vim Plugins

Vim works exceptionally well out of the box, and most things can be configured directly through the .vimrc file. Some things, however, take a lot more time to implement. Vim plugins allow us to easily add complex functionality to our vim instances.

My plugin manager of choice is [vim-plug](https://github.com/junegunn/vim-plug). The following plugins are inlcuded in `.vimrc`:

TODO: add this

### Fonts

- Web Serif: TODO
- Web Sans-serif: TODO
- Web Monospace: TODO
- Terminal: [Hack](https://github.com/source-foundry/Hack)

### Other

- Default Background: Arch Adapta
    - Resolution: 3840x2160
    - Source: https://www.reddit.com/r/UnixWallpapers/comments/71lcxo/
    - Original: https://github.com/adapta-project/adapta-backgrounds
    - Original Author: [Tista](https://github.com/tista500)
    - License: [Creative Commons Attribution-ShareAlike 3.0](https://creativecommons.org/licenses/by-sa/3.0/)
- Default Theme: Materia
    - Author: [Defman21](https://github.com/Defman21)
    - Source: https://github.com/chriskempson/base16-shell/blob/master/scripts/base16-materia.sh

## FAQ

Q: Why no status line or other information bar shown at all times?

A: New Start was built with minimalism and simplicity in mind. You're focusing on the current task at hand and nothing else. If you need to access certain information, you can, but having such information shown on the screen 24/7 goes against the founding principles of this operating system. Less is more.

## Help

By default I keep track of all the useful commands and other features I use on a daily basis. Although these are not a replacement for reading the manual pages, they do offer a quick insight on what is possible with certain software. For a list of available programs and other features that have help files, simply type `help` in the terminal. To access the help of a specific piece of software, type `help <software>`

If you find a bug or something isn't working for you, please file an issue with as many details as possible and I'll see what I can do. If you have the skills to fix it yourself, please do!

## Contributing

If you would like to contribute to this project then you can. Please file an issue or submit a pull request and I'll look into it. For reference, the directory structure is as follows:

- **dotfiles/** - All of my custom configuration files (integrated directly with the OS, unless specified otherwise)
- **help/** - All the built-in help pages I provide with the OS
- **install/** - Install scripts used during the installation process
