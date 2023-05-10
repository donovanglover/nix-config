# dotfiles

My [NixOS](https://nixos.org/) setup with [Nix Flakes](https://nixos.wiki/wiki/Flakes), [Home Manager](https://nix-community.github.io/home-manager/), and [Stylix](https://danth.github.io/stylix/), running [Hyprland](https://hyprland.org/).

## Goals

- Clean, readable code that can easily be modified to add/remove things as needed.
- A reasonably secure development environment isolated from personal files.

## Usage

```
git clone https://github.com/donovanglover/dotfiles && cd dotfiles
nixos-rebuild buildvm --flake .
./result/bin/run-*-vm
```

### Login

- Username: user
- Password: user
