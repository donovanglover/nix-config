# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

####################################################################
# Sudo and other system aliases
####################################################################

alias sudo="sudo " # Make aliases work with sudo (NOTE: Does not work with fish)
alias pls="sudo"   # A nicer way to ask for root permissions

alias rm="rm -i"        # Always confirm before deleting things (use -f to override)
alias mkdir="mkdir -p"  # Automatically make parent directories that don't exist yet

alias p="pwd | sed -e 's!$HOME!~!g'"    # Same as pwd, but uses ~ instead of $HOME

# Easily start fresh with a clean terminal
# Note that "clear force" (cf) clears the terminal for real and doesn't have
# any side effects when resizing windows or scrolling up
alias c="clear"
alias cf="tput reset"

# Make ls a lot easier to read (print directories first, just like ranger)
alias exa="exa --group-directories-first"
alias ls="exa"

alias l="exa -1"      # Show each output from ls on a separate line
alias lsa="exa -a"    # Show hidden files (also known as dotfiles)

alias where="type"    # An alternative for shells that don't use the where command

####################################################################
# Volume aliases
####################################################################

# Usage: vol 10%+ (Increase the volume by 10%), vol 10%- (Decrease by 10%)
# vol 100% (Set the volume to 100%)
alias vol="amixer set 'Master' "
alias volume="vol"

####################################################################
# Miscellaneous aliases
####################################################################

alias vz="nvim +Files"   # Open any file inside a directory easily with fzf
alias vh="nvim -i NONE -c 'set noswapfile' -c 'set noundofile' -c 'set nobackup'"

# Quick and easy way to download the majority of online videos
alias dl="youtube-dl -f bestvideo+bestaudio"

alias back="feh --no-fehbg --bg-fill"          # Easily set a new background (temporary)
alias synctime="ntpdate -u 0.us.pool.ntp.org"  # Sync the system time with one on the internet

# Show the lines that are in <file2> but NOT in <file1>
alias compare="grep -nFxvf" # Usage: compare <file1> <file2>

# "dog" is a colorful version of cat
alias dog="pygmentize -g"

# Easily show all of the todos in a given project
alias todo="rg TODO"

# Use exa as a drop-in replacement for "tree" (faster, more colors, etc.)
alias tree="exa --long --tree -I 'node_modules|lib'"
alias t="tree -L 1"
alias t2="tree -L 2"
alias t3="tree -L 3"
alias te="tree"

# Easily copy the contents of any file
alias copy="xclip -sel clip < "

####################################################################
# Git aliases
####################################################################

alias g="git"                       # In case we ever need to type a full command
alias ga="git add"                  # Swiftly add new files to the repository
alias gaa="git add --all"           # Quickly add all the files changed in a repository
alias gap="git add --patch"         # Commit a file one part at a time
alias gb="git branch --verbose"     # Show a list of all the branches in the repository
alias gc="git commit -m"            # Easily create new commits
alias gca="git commit --amend"      # Easily amend previous commits
alias gd="git diff"                 # Show all file changes that you haven't added yet
alias gds="git diff --staged"       # Show the changes you added but haven't committed yet
alias gg="git grep"                 # Easily grep for a string inside the git repository
alias gp="git push"                 # Push your commits to remote (usually origin)
alias gs="git status"               # Compare any local changes you've made to the remote
alias gr="git reset HEAD~"          # Undo the last commit but keep your changed files
alias gre="git remote --verbose"    # Show all the remotes for the repository
alias grr="git reset --hard HEAD~"  # Remove the last commit and all changes with it
alias gl="git lg"                   # Quickly show a list of the most recent commits

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
