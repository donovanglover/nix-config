# Easily clone and cd into GitLab repositories
# Usage: lab username/repository
function lab --argument-names "path"
    if test -n "$path"
        git clone git@gitlab.com:$path.git
        cd (basename "$path")
    else
        echo "No repository was specified."
        echo "Usage: lab username/repository"
    end
end
