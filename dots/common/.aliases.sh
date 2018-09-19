# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

alias c="clear"             # Because 5 letters is too much
alias dog="pygmentize -g"   # "dog" is a colorful version of cat
alias emacs="vim"           # No need to start another operating system

# Use exa as a drop-in replacement for ls and tree (faster, more colors, etc.)
alias ls="exa --group-directories-first"
alias tree="exa --group-directories-first --long --tree -I 'node_modules|lib|.git'"
