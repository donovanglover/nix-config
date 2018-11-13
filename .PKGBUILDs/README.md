# PKGBUILDs

Here are the PKGBUILDs I use to replicate my [Arch Linux](/.archlinux) rice. `muya.spec` is used to mimmic my entire [Fedora](/.fedora) setup. Change it as you see fit, or simply use what I use.

## Troubleshooting

### dnf: Remove unused dependencies

Unlike pacman, dnf will only remove unused dependencies if you use `dnf autoremove`.

### pacman: Invalid or corrupted package (PGP signature)

This happens when the keys used to sign packages have changed. Use `pacman-key --populate` to fetch new keys, followed by `--refresh-keys` to update any existing keys.
