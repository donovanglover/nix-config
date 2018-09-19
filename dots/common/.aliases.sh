# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

alias c="clear"

# Make ls a lot easier to read (print directories first, just like ranger)
alias exa="exa --group-directories-first"
alias ls="exa"
alias l="ls -l"

# Use exa as a drop-in replacement for "tree" (faster, more colors, etc.)
alias tree="exa --long --tree -I 'node_modules|lib|.git'"
alias t="tree"

# Change the volume, e.g. vol 10%+, vol 10%-, vol 100%
alias vol="amixer set 'Master' "

# Quick and easy way to download the majority of online videos
alias dl="youtube-dl -f bestvideo+bestaudio"

# Easily set a new background (temporary)
alias back="feh --no-fehbg --bg-fill"

# Show the lines that are in <file2> but NOT in <file1>
alias compare="grep -nFxvf" # Usage: compare <file1> <file2>

# "dog" is a colorful version of cat
alias dog="pygmentize -g"

# Easily copy the contents of any file
alias copy="xclip -sel clip < "

####################################################################
# Launch aliases (allow us to easily open external programs)
####################################################################

alias f="launch feh --auto-zoom"    # Easy image viewing with f
alias z="launch zathura"            # Easy document browsing with z
alias m="launch mpv"                # Easy media playing with m
alias lnox="launch inox"            # Launch inox separate from the terminal
alias lfox="launch firefox"         # Launch firefox separate from the terminal

####################################################################
# Fun aliases that don't serve any specific purpose
####################################################################

alias emacs="nvim"      # No need to start another operating system
alias nano="nvim"       # Why nano when you have vim?
alias vi="nvim"         # Vim is vi improved, literally
