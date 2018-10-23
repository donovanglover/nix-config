# Git

I use git as my main tool for distributed version control.

## Dependencies

- [git][git] - The standard version control system

## Installation

```sh
make package=git
```

## Usage

Add a `.gituser` file to your `$HOME` with the following:

```gitconfig
[user]
  name = <the name you use for git commits>
  email = <the email you use for git commits>
  signingkey = <the subkey you use to sign git commits>
```

[git]: https://www.archlinux.org/packages/extra/x86_64/git/
