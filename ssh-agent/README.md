# ssh-agent

[SSH][ssh] is used to connect to remote machines. I use a systemd service to manage ssh-agent.

## Use Cases

ssh-agent can be used to:

- Hold private keys

You should not use ssh-agent if:

- You don't set a passphrase on your SSH keys

## Usage

```sh
systemctl --user enable --now ssh-agent.service
```

In order for ssh-agent to cache your keys, you must first add them with `ssh-add` or use `AddKeysToAgent Yes` in your `~/.ssh/config`

[ssh]: https://www.archlinux.org/packages/core/x86_64/openssh/
