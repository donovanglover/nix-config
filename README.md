# nix-config

My [NixOS](https://nixos.org/) config with [Nix Flakes](https://nixos.wiki/wiki/Flakes), [Home Manager](https://nix-community.github.io/home-manager/), [Stylix](https://danth.github.io/stylix/), and [Hyprland](https://hyprland.org/).

## Goals

- Clean, readable code that can easily be modified to add/remove things as needed.
- A reasonably secure development environment isolated from personal files.

## Structure

- `./applications/` - GUI applications
- `./common/` - Common configs
- `./desktop/` - Hyprland config
- `./dev/` - Dev stuff
- `./host/` - Host-specific config
- `./terminal/` - Terminal programs

## Usage

```fish
git clone https://github.com/donovanglover/dotfiles && cd dotfiles
nixos-rebuild buildvm --flake .
./result/bin/run-*-vm
```

### Login

- Username: user
- Password: user
