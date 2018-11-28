# Git

[Git][git] is the standard version control tool.

# Use Cases

Git can be used to:

- Keep track of file changes over time
- Keep a record of all contributors to a code base
- Rollback to a previous version of a project
- Create snapshots of a project with tags (also known as versions)

You should not use Git if:

- You are dealing with binary files
- You are dealing with large files that change often

## Usage

First, install [diff-so-fancy][diff-so-fancy], an amazing git diff utility.

Then, create a `~/.gituser` with the following:

```gitconfig
[user]
  name = <the name you use for git commits>
  email = <the email you use for git commits>
  signingkey = <the subkey you use to sign git commits>
```

[git]: https://github.com/git/git
[diff-so-fancy]: https://github.com/so-fancy/diff-so-fancy
