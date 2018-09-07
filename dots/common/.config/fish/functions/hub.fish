# Easily clone and cd into GitHub repositories
# Usage: hub username/repository [upstream]
function hub --argument-names "path" "upstream"
    if test -n "$path"
        git clone ssh://git@github.com/$path.git
        cd (basename "$path")

        if test -n "$upstream"
            git remote add upstream \
                ssh://git@github.com/$upstream/(basename "$path").git
        else
            echo "Note: No upstream was specified."
        end
    else
        echo "No repository was specified."
        echo "Usage: hub username/repository [upstream]"
    end
end
