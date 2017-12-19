# New Start - Less is More.

> Vim is my editor, \*nix is my IDE.

TODO: Put images here

## Usage

Some important things to note:

1. Linux is not an operating system. It is simply a kernel used as part of an operating system. All the so-called Linux distributions are actually distributions of GNU/Linux.
2. Arch is rolling release. You will always have the latest software. There is no such thing as "updating to the next version of Arch".
3. Keep it simple. At the end of the day, you only need to use your computer for a few specific tasks, such as listening to music, writing software, sending messages, and using the internet.
4. You have complete control over your software. There is no need to insult your computer. If something doesn't work, it's more often than not user error.

### Design Goals

Simplicity. Minimalism. Elegance.

1. **Simplicity.** It should be trivial to find and edit the things you're looking for.
2. **Reproducability.** It should be trivial to reconfigure all of your settings from a fresh install.
3. **Minimal.** It should only have what you need and nothing else.

### Usability Goals

1. **Everything just works.** There is no need to configure anything. You simply go through the installation and you're looking at an identical workspace as before.
2. **Automation.** Important things like making backups and cleaning up should be automatic.
3. **Virtualization.** It should be trivial to setup a fresh working environment in a brand new virtual machine.
4. **Configuration is self-documenting.** It is trivial for someone to view and understand how the dotfiles work.

## Build from Source

**Important:** Do *not* attempt to run this script on your physical machine. This script was made for and has only been tested in a fresh new virtual machine running the Arch Linux ISO.

Boot into the Arch Linux ISO. Then, run the following commands:

```
wget https://raw.githubusercontent.com/GloverDonovan/new-start/master/install.sh
chmod +x install.sh
./install.sh <HOSTNAME> <LOCALUSER>
```

Replace `<HOSTNAME>` with your preferred hostname and `<LOCALUSER>` with the name of the user account to create.

The default password for your new account is the same as your username. Upon reboot, the X server should automatically start at login. Then:

1. Change the root password with `passwd`
2. Change the local account password with `passwd <username>`

That's it! You're now ready to use your shiny new system!

The install includes a variety of languages by default, including C, C++, Perl, Go, Ruby, Lua, Java, PHP, Python, Crystal, Elixir, and Rust.

Note that this list is not exhaustive. Other languages like Markdown, HTML, CSS, and Sass also work by default.

For a list of all packages installed and why they were installed, please see `install/packages.sh`.

The default wallpaper is [Arch Adapta](https://www.reddit.com/r/UnixWallpapers/comments/71lcxo/). The [original](https://github.com/adapta-project/adapta-backgrounds) was made by [Tista](https://github.com/tista500) and is released under the [Creative Commons Share-Alike 3.0](https://creativecommons.org/licenses/by-sa/3.0/) license.

By default I keep track of the many useful commands and other features I use on a daily basis. Please not that these are not a replacement for reading the man pages of said software.

## A Note on Free Software

Often as end-users we come across a variety of roadblocks that prevent us from doing what we want to get done. "If only this program could do X" or "if only my operating system was better at handling Y".

**Proprietary software** forces us to accept whatever inconveniences we face as a matter of fact. We will have to deal with these inconveniences until the upstream developers decide to do something with it. Proprietary software may also change at any time, forcing the end-user to conform to new practices whether they like it or not.

**Free software**, on the other hand, allow us to have complete control of our computers. If something doesn't work, we can fix it. If we want to change something, we can change it. We're not waiting for or trusting anyone else to do it. We have the power to change the things we don't like and redistribute them for others to use.

Free software promotes innovation. How? Anyone is allowed to contribute to the upstream project. If someone doesn't agree with the direction a piece of software is going, they have the freedom to modify the software and redistribute those modifications to the community. If a particular piece of software goes downstream or starts promoting malicious activities, it is trivial for users to switch to the modified software.

Free software is a competitive environment decided by the people. Vendor lock-in is limited; if your software doesn't conform to the user's wants--the user's needs, another piece of software will.

Do not confuse free software with freeware. **Freeware** is any piece of software that is distributed with no price; however, freeware is *not* free software. **Free software**, in comparison, *may* come with a price. Free software in this context refers to the freedom to do anything with the software you obtain, whether you have to pay for it or not.

Compare this to **proprietary software**, which often impose restrictions on how you can use the software *even after you purchase it*. Legally speaking, your rights to the software are restricted before you even decide to buy it. If you don't like something and want to change it, you're not able to, even if you paid for it.

A software *S* is said to be **free software** if and only if:

1. You have the freedom to use the software as you wish, for any purpose.
2. You have the freedom to study how the program works, and change it so the program works for you and not the other way around.
3. You have the freedom to redistribute copies of the software, similar to sharing your music with a friend, but with software.
4. You have the freedom to distribute modified versions of the software to others. This makes it possible for everyone else to benefit from your changes. 

A software that does not adhere to the above conditions is said to be **nonfree software**. Nonfree software includes freeware, that is, software offered at no price but does not grant the four freedoms.

It is important to note that **open source software** is *not* free software. Anyone can publish their code online. This code is still limited by the terms set forth in the **software license**.

Freedom is a powerful thing. You don't realize what you don't have. But when you have it, you never want to lose it. Freedom works the same way. Once you experience the freedom of being able to change any part of your system, at any time and for any reason, without anyone or anything else restricting you otherwise, you start to wonder how you ever managed without such freedoms.

The age-old saying still goes: with great power comes great responsibility. You aren't hindered by any external limits; only yourself. There are no handlebars. Anything you do is done. You are responsible for your own software. You have complete control.
