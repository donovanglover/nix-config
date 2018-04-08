pkgname=new-start
pkgver=0.1.0
pkgrel=1
pkgdesc="A modern Arch workflow built with an emphasis on functionality."
arch=('any')
license=('GPL')
depends=(
    # Core system
    'grub'          # Bootloader
    'fish'          # No more zsh hacks (zsh + grml-zsh-config + zsh-syntax-highlighting)
    'openssh'       # SSH client + server support
    'openvpn'       # VPN client + server support
    'zip'           # Make zip files
    'unzip'         # Extract zip files
    'p7zip'         # Extract 7z files
    'unrar'         # Extract rar files
    'ntp'           # Sync time with a remote machine
    'firejail'      # An easy way to sandbox programs

    # X server stuff
    'xorg-server'   # Core X serer
    'xorg-xinit'    # (?) .xinitrc support
    'xdo'           # Show / hide windows
    'xdotool'       # (?) Forward search support
    'xorg-xprop'    # (?) Get window status
    'xclip'         # (?) Clipboard manager
    'xcape'         # Make Caps Lock = Ctrl/ESC

    # VirtualBox stuff
    'virtualbox-guest-utils'        # Core VirtualBox functionality
    'virtualbox-guest-modules-arch' # Arch-specific modules

    # Text editor
    'vim'       # Vim for GPG and tty
    'neovim'    # Neovim for everything else

    # Formal (Programming) languages
    'crystal'   # Language of choice
    'rustup'    # Another language of choice

    # Build tools
    'llvm'      # The low level virtual machine
    'git'       # Version control
    'libsass'   # Sass support
    'shards'    # Crystal package manager
    'npm'       # Node package manager
    'yarn'      # Dependency manager

    # Main environment
    'bspwm'         # Window manager
    'sxhkd'         # Hotkey daemon
    'rxvt-unicode'  # Terminal emulator
    'compton'       # Compositor

    # Main software
    'ranger'    # File explorer
    'feh'       # Image viewer
    'mpd'       # Music player daemon
    'mpc'       # Music player client
    'ncmpcpp'   # Ncurses music player client
    'mpv'       # Video player
    'weechat'   # IRC client
    'profanity' # XMPP client
    'w3m'       # Web browser
    'zathura'   # Document viewer
    'zathura-djvu'      # .djvu support
    'zathura-pdf-mupdf' # .pdf support

    # Misc tools that make things easier
    'jq'        # JSON manipulation
    'httpie'    # Make HTTP requests
    'tig'       # Interface for Git
    'fdupes'    # Find duplicate files
    'ripgrep'   # Faster than ag / ack / grep
    'fzf'       # Fuzzy find all the things
    'ncdu'      # Ncurses du (disk usage)
    'borg'      # Backup directories
    'exa'       # Drop-in replacement for ls and tree
    'fd'        # Faster alternative to find
    'bind-tools'    # DNS tools like dig
    'diff-so-fancy' # A better-looking git diff
    'youtube-dl'    # View online videos in mpv
    'xdg-user-dirs' # Generates common directories

    # Fonts
    'ttf-hack'      # Terminal font
    'ttf-fira-mono' # Polybar font
    'noto-fonts'    # Everything else

    # Other languages
    'elixir'
    'ruby'
    'go'
    'php'
    'jdk-9-openjdk'
    'python'
    'lua'
    'nodejs'
    'ghc'

    # Other extras
    'pygmentize' # Command line syntax highlighting (used for 'dog')
    'ctags'      # ctags (used with vim)
    'ispell'     # Spell checker (an alternative to the built-in vim one)
    'alsa-utils' # (?) Required for sound support

    # (La)TeX
    'texlive-core'          # TeX core
    'texlive-science'       # TeX + the formal sciences (mathematics, etc.)
    'texlive-pictures'      # Graphics support
    'texlive-publishers'    # Publisher formats
    'texlive-latexextra'    # LaTeX extras
    'texlive-humanities'    # TeX isn't just for mathematics
    'texlive-fontsextra'    # More fonts
    'texlive-formatsextra'  # More formats
    'texlive-bibtexextra'   # More features for BibTeX
    'minted'                # Add syntax highlighting support to LaTeX

    'avidemux-cli'  # Command line video editor
    'sox'           # Audacity for the terminal
    'tmux'          # Terminal multiplexer
)

package() {
    gem install haml
    gem install sass
    gem install lolcat
    gem install jekyll
}
