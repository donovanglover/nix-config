# xmodmap

[xmodmap][xmodmap] is used to change the functionality of keys on your keyboard.

## Use Cases

xmodmap can be used to:

- Make Caps Lock function as Ctrl when held down
- Used with [xcape][xcape] to make Caps Lock function as Escape when pressed

You should not use xmodmap if:

- You do not need to modify keys

## Usage

Run `xmodmap ~/.xmodmap` in one of your init scripts to make Caps Lock function as Ctrl when held down.

Then, use `xcape -e 'Control_L=Escape'` to make Caps Lock (left Ctrl) function as Escape when pressed.

[xmodmap]: https://wiki.archlinux.org/index.php/Xmodmap
[xcape]: https://github.com/alols/xcape
