#set -U fish_greeting ""
#set -U fish_history ""
#set -U fish_user_paths
#set -U BROWSER "waterfox"

fish_vi_key_bindings

alias c="clear"
alias cf="tput reset"
alias pls="sudo"
alias rm="rm -i"
alias mkdir="mkdir -p"

alias exa="exa --group-directories-first"
alias ls="exa"
alias l="ls -l"
alias lsa="ls -a"
alias tree="exa --long --tree"
alias t="tree -L 1"

alias todo="rg TODO"
alias pwd="pwd | sed -e 's!$HOME!~!g'"
