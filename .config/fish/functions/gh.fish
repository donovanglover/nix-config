# Easily cd into the "home" directory of any repository you're
# working in.
function gh
    cd (git rev-parse --show-toplevel)
end
