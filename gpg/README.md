# GPG

GPG is used to sign and encrypt things.

## Dependencies

- [`gnupg`][gnupg] - The GNU Privacy Guard

## Installation

```sh
make package=gpg
```

## Usage

Use gpg as you normally would. Make sure that you export `GPG_TTY` in your shell's init script. This is how you would do it in [fish](/fish):

```fish
export GPG_TTY=(tty)
```

[gnupg]: https://www.archlinux.org/packages/core/x86_64/gnupg/
