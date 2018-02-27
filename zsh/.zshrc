# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

export VISUAL="nvim"
export EDITOR="nvim"
export BROWSER="waterfox"

# Use rg instead of ag / ack / grep for fzf (much faster)
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

# Required to make gpg-agent work in cases like git commit
export GPG_TTY=$(tty)

# Autosuggest commands in the terminal
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH" # Add ruby gems to $PATH

# Add custom software to $PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/bin:$PATH"

export FZF_DEFAULT_OPTS='--height 40% --reverse --border --color=16'

autoload -Uz compinit && compinit
autoload -Uz promptinit && promptinit
autoload -Uz vcs_info

# Add my own custom prompt, simple and minimal
prompt off
PROMPT="%F{magenta}%1~%f %B%F{red}➤%F{green}➤%F{blue}➤%f%b "

# Ignore cached commands (finds new ones without restarting the terminal)
zstyle ':completion:*' rehash true

# Never prompt for a huge list, page it
zstyle ':completion:*:default' list-prompt '%S%M matches%s'

# Make the list a menu that you can go through
zstyle ':completion:*:default' menu 'select=0'

# Color code tab completion
zstyle ':completion:*' list-colors "=(#b) #([0-9]#)*=36=31"

# Source our aliases first, then our functions (some functions rely on aliases)
source ~/.aliases.sh
source ~/.zsh_functions.zsh

# Source our dircolors
eval "$(dircolors ~/.dircolors)"

# Use our dircolors for the autocompletion feature of zsh so everything looks consistent
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Add syntax highlighting to zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
