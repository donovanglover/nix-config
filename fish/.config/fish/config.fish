# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

set -U fish_greeting ""
set -U fish_history ""
set -U fish_user_paths

export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="firefox"
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export GPG_TTY=(tty)

set x (ruby -e 'print Gem.user_dir')

export PATH="$x/bin:$PATH" # Add ruby gems to $PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export FZF_DEFAULT_OPTS='--height 40% --reverse --border --color=16'

fish_default_key_bindings

source ~/.aliases.sh

# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end
