# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2022 Donovan Glover

set -U fish_greeting ""

export VISUAL="nvim"
export EDITOR="nvim"
export PATH="$HOME/.deno/bin:$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.local/bin:$HOME/.go/bin:$PATH"
export NODE_OPTIONS="--max_old_space_size=16384"
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export GOPATH="$HOME/.go"
export TERMCMD="kitty --single-instance"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

# Use rg instead of ag / ack / grep for fzf (much faster)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --color=16'

# Required to make gpg-agent work in cases like git commit
export GPG_TTY=(tty)

# Add color to man pages
set -x -U LESS_TERMCAP_md (printf "\e[01;31m")
set -x -U LESS_TERMCAP_me (printf "\e[0m")
set -x -U LESS_TERMCAP_se (printf "\e[0m")
set -x -U LESS_TERMCAP_so (printf "\e[01;44;30m")
set -x -U LESS_TERMCAP_ue (printf "\e[0m")
set -x -U LESS_TERMCAP_us (printf "\e[01;32m")

# Always use the default keybindings in fish
fish_default_key_bindings

# Use https by default without a user agent for httpie
function http
    /usr/bin/https "$argv" "User-Agent: "
end

function https
    /usr/bin/https "$argv" "User-Agent: "
end

# Convert unnecessarily large wav files to flac
function wav2flac
    set ORIGINAL_SIZE (du -hs | cut -f1)

    fd -e wav -x ffmpeg -i "{}" -loglevel quiet -stats "{.}.flac"
    fd -e wav -X trash

    set NEW_SIZE (du -hs | cut -f1)

    echo "Done. Reduced file size from $ORIGINAL_SIZE to $NEW_SIZE"
end

# Easily extract files and remove the archive
function ex
    unar "$argv"; and rm -i "$argv"
end

# Don't show ripgrep results for very long lines (e.g. minified files)
alias rg="rg --max-columns=2000"

# Use exa as a drop-in replacement for ls and tree (faster, more colors, etc.)
alias ls="exa --group-directories-first -I 'lost+found'"
alias tree="exa --group-directories-first --long --tree -I 'node_modules|.git|public|lost+found'"

# Prevent accidents
alias mv="mv -i"

# Always use kitty ssh since it's our default terminal
if string match -qe -- "/dev/pts/" (tty)
    alias ssh="kitty +kitten ssh"
end

# Source wal colors as needed
if status is-interactive; and test "$TERM" = "xterm-256color"
    cat ~/.cache/wal/sequences
end

# Abbreviations are aliases that expand
if not set -q set_abbr
    set -U set_abbr
    abbr g      "git"
    abbr ga     "git add"
    abbr gaa    "git add --all"
    abbr gap    "git add --patch"
    abbr gb     "git branch"                # List all branches
    abbr gc     "git commit -m"
    abbr gca    "git commit --amend"
    abbr gcl    "git clone"
    abbr gco    "git checkout"
    abbr gd     "git diff"                  # Show all file changes not staged yet
    abbr gdi    "git difftool --no-symlinks --dir-diff"
    abbr gds    "git diff --staged"         # Show changes staged but not committed
    abbr gdsi   "git difftool --no-symlinks --dir-diff --staged"
    abbr gi     "git init"
    abbr gl     "git log --oneline --decorate --all --graph -n 10"
    abbr gm     "git merge"
    abbr gp     "git push"                  # Push your commits to a remote server
    abbr gr     "git reset HEAD~"           # Undo the last commit but keep changed files
    abbr gra    "git remote add"
    abbr gre    "git remote --verbose"      # List all remotes
    abbr grh    "git reset HEAD"
    abbr grr    "git reset --hard HEAD~"    # Remove the last commit and all changes with it
    abbr gs     "git status"
    abbr gst    "git stash"
    abbr gstp   "git stash pop"
    abbr gt     "git tag"
    abbr gts    "git tag -s"

    abbr d      "sudo docker"
    abbr dc     "sudo docker-compose"
    abbr dcu    "sudo docker-compose up"
    abbr dcd    "sudo docker-compose down"
    abbr dcp    "sudo docker-compose pull"
    abbr dcl    "sudo docker-compose logs"

    abbr y      "yarn"
    abbr ya     "yarn add"
    abbr yar    "yarn remove"
    abbr yi     "yarn init"
    abbr yin    "yarn install"
    abbr yu     "yarn upgrade-interactive"

    abbr v      "vagrant"
    abbr vu     "vagrant up"
    abbr vh     "vagrant halt"
    abbr vs     "vagrant ssh"
    abbr vp     "vagrant provision"

    abbr dl     "yt-dlp"
    abbr vol    "amixer set 'Master'"       # Change the volume, e.g. vol 10%+, vol 10%-, vol 100%
    abbr copy   "xclip -sel clip <"         # Easily copy the contents of any file
    abbr cf     "tput reset"                # Clear the terminal completely
    abbr nf     "tput reset; and neofetch --size 56%; and xdotool key --delay 100 Ctrl+Shift+Page_Up"
    abbr df     "df --human-readable --type=ext4 --total"
    abbr du     "du --human-readable --summarize"
    abbr jis    "recode shift_jis..utf8"    # Easily convert shift_jis-encoded files to utf8
    abbr utf16  "recode utf16..utf8"        # Rarely, some files from Japan are utf16 instead
    abbr jp     "LANG=ja_JP.UTF-8 LC_ALL=ja_JP.UTF-8"

    abbr a      "ansible-playbook"
    abbr b      "feh --bg-fill"             # Change the background
    abbr c      "clear"                     # Because 5 letters is too much
    abbr e      "exit"
    abbr k      "kitty @ set-colors -c -a ~/.cache/wal/kitty"
    abbr l      "ls -l"
    abbr p      "paru"
    abbr r      "ranger"
    abbr w      "wal -o ~/.config/wal/done.sh"
    abbr T      "tree"

    abbr nano   "vim"                       # The explanation is in the name
    abbr emacs  "vim"                       # No need to start another operating system
end

starship init fish | source
