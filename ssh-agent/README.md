# ssh-agent

SSH is used to connect to remote machines. I use a systemd service to manage ssh-agent.

## Dependencies

- [openssh][openssh] - SSH support

## Installation

```sh
make package=ssh-agent
```

## Usage

```sh
systemctl --user enable --now ssh-agent.service
```

In order for ssh-agent to cache your keys, you must first add them with `ssh-add`.

[openssh]: https://www.archlinux.org/packages/core/x86_64/openssh/
