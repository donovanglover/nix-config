# Easily cd into the "home" directory of any repository you're
# working in. Note that this is a function instead of an alias
# since `external calls` in aliases are not supported by zsh.
# The current aliases file works with fish and other shells like
# zsh.
function gh
    cd (git rev-parse --show-toplevel)
end
