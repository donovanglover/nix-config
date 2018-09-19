# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

set -U fish_greeting ""

export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="firefox"

# Use rg instead of ag / ack / grep for fzf (much faster)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --color=16'

# Required to make gpg-agent work in cases like git commit
export GPG_TTY=(tty)

# Always use the default keybindings in fish
fish_default_key_bindings

# Source our aliases
source ~/.aliases.sh

if not set -q set_abbr
    set -U set_abbr
    abbr g      "git"
    abbr ga     "git add"
    abbr gaa    "git add --all"
    abbr gap    "git add --patch"
    abbr gb     "git branch --verbose"      # List all branches
    abbr gc     "git commit -m"
    abbr gca    "git commit --amend"
    abbr gd     "git diff"                  # Show all file changes not staged yet
    abbr gds    "git diff --staged"         # Show changes staged but not committed
    abbr gg     "git grep"
    abbr gl     "git log --oneline --decorate --all --graph -n 10"
    abbr gp     "git push"                  # Push your commits to a remote server
    abbr gs     "git status -s"
    abbr gss    "git status"
    abbr gr     "git reset HEAD~"           # Undo the last commit but keep changed files
    abbr gre    "git remote --verbose"      # List all remotes
    abbr grh    "git reset head"
    abbr grr    "git reset --hard HEAD~"    # Remove the last commit and all changes with it
end

# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end
