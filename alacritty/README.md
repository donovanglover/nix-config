# alacritty

[alacritty][alacritty] is a new terminal emulator written in Rust.

## Use Cases

alacritty can be used to:

- Have a terminal emulator that just works
- Have a terminal emulator with modern features like live reload, and without all the extras like window management
- Master [tmux](/tmux) since you won't be relying on window management of your terminal emulator

You should not use alacritty if:

- You have a desire to output images in your terminal (use [kitty](/kitty) instead since [libsixel][libsixel] support is WIP)
- You have a need to use Japanese input in your terminal ([an issue][ime-support] for over 3 years in alacritty, [kitty](/kitty) supports this)

[alacritty]: https://github.com/alacritty/alacritty
[libsixel]: https://github.com/alacritty/alacritty/issues/910
[ime-support]: https://github.com/alacritty/alacritty/issues/1101
