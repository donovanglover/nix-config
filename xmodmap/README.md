# xmodmap

I use xmodmap with xcape to make Caps Lock function as Escape when pressed and Ctrl when held down.

## Dependencies

- `xorg-xmodmap` - Used to make caps lock work as ctrl
- `xcape` - Used to make caps lock work as escape

## Installation

```sh
make package=xmodmap
```

## Usage

Start `xmodmap` in one of your init scripts, like so:

```sh
# Make caps lock work as ctrl
xmodmap ~/.xmodmap
```

To make caps lock work as Escape, start xcape as well:

```sh
# Make caps lock (left ctrl) work as escape
xcape -e 'Control_L=Escape'
```
