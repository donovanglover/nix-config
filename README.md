# nix-config

My [NixOS] configuration with [Nix Flakes], [Home Manager], [Stylix], and [Hyprland].

![A screenshot of Pepper looking earnestly at declaratively configured Git abbreviations for the fish shell, written in Nix.](./cover.jpg)
<sub>Background art: [The market](https://www.peppercarrot.com/en/viewer/artworks__2022-02-21_The-market_by-David-Revoy.html), [In Bloom](https://www.peppercarrot.com/en/viewer/artworks__2022-03-02_In-Bloom_by-David-Revoy.html) and [Vertical cover book two screen](https://www.peppercarrot.com/en/viewer/artworks__2016-11-14_vertical-cover-book-two_screen_by-David-Revoy.html) by David Revoy − [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.en).</sub>

![A screenshot of a Rust programming environment with Neovim, kitty, and bacon.](./.github/screenshots/neovim.png)
<sub>Background art: [Video game jam](https://www.peppercarrot.com/en/viewer/misc__2023-06-12_video-game-jam_by-David-Revoy.html) by David Revoy − [CC-BY 4.0](https://creativecommons.org/licenses/by/4.0/deed.en).</sub>

## Features

- Clean, readable code that can be easily modified to add/remove things as needed.
- Fully reproducible and declarative environment thanks to NixOS.
- Reasonably secure containers isolated from your personal files and network.
- Nix Flakes + Home Manager + Btrfs on LUKS.
- Simple yet effective Neovim setup with nvim-lspconfig.
- Modern Wayland support with Hyprland and the master-stack layout.
- Full Japanese support with fonts, input method, and wine covered.
- Specializations for easy switching between Hyprland, GNOME, and Plasma.
- A universal color scheme inherited by all applications.

## Usage

```fish
git clone https://github.com/donovanglover/nix-config && cd nix-config
nixos-rebuild build-vm --flake .#nixos
./result/bin/run-nixos-vm
```

The code base is designed to be small so it's easy to adjust things as needed. Have fun!

[NixOS]: https://nixos.org/
[Nix Flakes]: https://wiki.nixos.org/wiki/Flakes
[Home Manager]: https://nix-community.github.io/home-manager/
[Stylix]: https://danth.github.io/stylix/
[Hyprland]: https://hyprland.org/
