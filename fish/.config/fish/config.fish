# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

set -U fish_greeting ""

export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="firefox"

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export XDG_CURRENT_DESKTOP="KDE"

# Use rg instead of ag / ack / grep for fzf (much faster)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --color=16'

# Required to make gpg-agent work in cases like git commit
export GPG_TTY=(tty)

# Always use the default keybindings in fish
fish_default_key_bindings

# Use exa as a drop-in replacement for ls and tree (faster, more colors, etc.)
alias ls="exa --group-directories-first"
alias tree="exa --group-directories-first --long --tree -I 'node_modules|lib|.git'"

# Abbreviations are aliases that expand
if not set -q set_abbr
    set -U set_abbr
    abbr g      "git"
    abbr ga     "git add"
    abbr gaa    "git add --all"
    abbr gap    "git add --patch"
    abbr gb     "git branch --verbose"      # List all branches
    abbr gc     "git commit -m"
    abbr gca    "git commit --amend"
    abbr gco    "git checkout"
    abbr gd     "git diff"                  # Show all file changes not staged yet
    abbr gds    "git diff --staged"         # Show changes staged but not committed
    abbr gg     "git grep"
    abbr gi     "git init"
    abbr gl     "git log --oneline --decorate --all --graph -n 10"
    abbr gp     "git push"                  # Push your commits to a remote server
    abbr gs     "git status"
    abbr gss    "git status -s"
    abbr gr     "git reset HEAD~"           # Undo the last commit but keep changed files
    abbr gre    "git remote --verbose"      # List all remotes
    abbr grh    "git reset HEAD"
    abbr grr    "git reset --hard HEAD~"    # Remove the last commit and all changes with it

    abbr t      "task"
    abbr ta     "task add"
    abbr tc     "task completed"
    abbr td     "task done"
    abbr te     "task edit"

    abbr dl     "youtube-dl"
    abbr vol    "amixer set 'Master'"       # Change the volume, e.g. vol 10%+, vol 10%-, vol 100%
    abbr copy   "xclip -sel clip <"         # Easily copy the contents of any file
    abbr dog    "pygmentize -g"             # "dog" is a colorful version of cat
    abbr cf     "tput reset"                # Clear the terminal completely

    abbr b      "feh --bg-fill"             # Change the background
    abbr c      "clear"                     # Because 5 letters is too much
    abbr e      "exit"
    abbr l      "ls -l"
    abbr w      "wal -o ~/.config/wal/done.sh"
    abbr T      "tree"

    abbr nano   "vim"                       # The explanation is in the name
    abbr emacs  "vim"                       # No need to start another operating system
end

# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end
