##################################################################################
# 
#    New Start: A modern Arch workflow built with an emphasis on functionality.
#    Copyright (C) 2017 Donovan Glover
# 
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
# 
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
# 
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
# 
##################################################################################

export VISUAL="vim"
export EDITOR="vim"
export BROWSER="inox"

# Use ag instead of grep for fzf (much faster)
export FZF_DEFAULT_COMMAND='ag -l -g ""'

# Required to make gpg-agent work in cases like git commit
export GPG_TTY=$(tty)

# Autosuggest commands in the terminal
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH="$(ruby -e 'print Gem.user_dir')/bin:$PATH" # Add ruby gems to $PATH

# Add custom software to $PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Home/new-start/bin:$PATH"

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
source ~/.zsh_aliases
source ~/.zsh_functions

# Source our dircolors
eval "$(dircolors ~/.dircolors)"

# Use our dircolors for the autocompletion feature of zsh so everything looks consistent
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 

# Add syntax highlighting to zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
