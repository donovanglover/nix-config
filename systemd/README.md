# systemd

*systemd* is described as "a suite of basic building blocks for a Linux system". One of the functions it can be used for is starting daemons at login.

## Dependencies

- [openssh][openssh] - `ssh-agent.service` support
- [rxvt-unicode-patched][rxvt-unicode-patched] - `urxvtd.service` support
- [mpd][mpd] - `mpd.service` support

## Installation

```sh
make package=systemd
```

## Usage

To start all the user services I use, run:

```sh
make systemd-enable-now
```

If you only want to start certain services instead, start them like you normally would with systemd.

### ssh-agent

In order for ssh-agent to cache your keys, you must first add them. You can do this by using `ssh-add`.

[openssh]: https://www.archlinux.org/packages/core/x86_64/openssh/
[rxvt-unicode-patched]: https://aur.archlinux.org/packages/rxvt-unicode-patched/
[mpd]: https://www.archlinux.org/packages/extra/x86_64/mpd/
