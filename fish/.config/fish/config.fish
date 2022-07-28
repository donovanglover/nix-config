# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2022 Donovan Glover

set -U fish_greeting ""

export VISUAL="nvim"
export EDITOR="nvim"
export PATH="$HOME/.deno/bin:$HOME/.cargo/bin:$HOME/.yarn/bin:$HOME/.local/bin:$HOME/.go/bin:$PATH"
export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/config"
export NODE_OPTIONS="--max_old_space_size=16384"
export GIT_DISCOVERY_ACROSS_FILESYSTEM=1
export GOPATH="$HOME/.go"

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

# Use exa as a drop-in replacement for ls and tree (faster, more colors, etc.)
alias ls="exa --group-directories-first -I 'lost+found'"
alias tree="exa --group-directories-first --long --tree -I 'node_modules|.git|public|lost+found'"

# Prevent accidents
alias mv="mv -i"

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
    abbr gds    "git diff --staged"         # Show changes staged but not committed
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

    abbr y      "yarn"
    abbr ya     "yarn add"
    abbr yar    "yarn remove"
    abbr yi     "yarn init"
    abbr yin    "yarn install"
    abbr yu     "yarn upgrade-interactive"

    abbr dl     "youtube-dl"
    abbr vol    "amixer set 'Master'"       # Change the volume, e.g. vol 10%+, vol 10%-, vol 100%
    abbr copy   "xclip -sel clip <"         # Easily copy the contents of any file
    abbr cf     "tput reset"                # Clear the terminal completely
    abbr nf     "tput reset; and neofetch --size 56%; and xdotool key --delay 100 Ctrl+Shift+Page_Up"
    abbr df     "df --human-readable --type=ext4 --total"

    abbr b      "feh --bg-fill"             # Change the background
    abbr c      "clear"                     # Because 5 letters is too much
    abbr e      "exit"
    abbr k      "kitty @ set-colors -c -a ~/.cache/wal/kitty"
    abbr l      "ls -l"
    abbr p      "paru"
    abbr w      "wal -o ~/.config/wal/done.sh"
    abbr T      "tree"

    abbr nano   "vim"                       # The explanation is in the name
    abbr emacs  "vim"                       # No need to start another operating system
end

starship init fish | source
