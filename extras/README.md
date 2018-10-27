# Extras

Some other programs I use that have dotfiles.

## Dependencies

- [httpie][httpie] - A friendly version of curl / wget
- [feh][feh] - A GUI-less image viewer
- [mpd][mpd] - The music player daemon
- [ncmpcpp][ncmpcpp] - A stylish music player client for the terminal
- [youtube-dl][youtube-dl] - A program that can download online videos
- [ranger][ranger] - A file explorer with image preview support for the terminal
- [rtv][rtv] - A reddit browser for the terminal
- [yay][yay] - An AUR helper for Arch Linux
- [mpv][mpv] - A media player without the GUI

## Installation

```sh
make package=extras
```

## Usage

Use these programs like you normally would, and the settings will be automatically applied.

### Ranger

In order to make image previews work with ranger, you must first copy the preview script.

```sh
ranger --copy-config=scope
```

[httpie]: https://www.archlinux.org/packages/community/any/httpie/
[feh]: https://www.archlinux.org/packages/extra/x86_64/feh/
[mpd]: https://www.archlinux.org/packages/extra/x86_64/mpd/
[ncmpcpp]: https://www.archlinux.org/packages/community/x86_64/ncmpcpp/
[youtube-dl]: https://www.archlinux.org/packages/community/any/youtube-dl/
[ranger]: https://www.archlinux.org/packages/community/any/ranger/
[rtv]: https://aur.archlinux.org/packages/rtv
[yay]: https://aur.archlinux.org/packages/yay
[mpv]: https://www.archlinux.org/packages/community/x86_64/mpv/
