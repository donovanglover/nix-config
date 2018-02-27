# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

set -U fish_greeting ""
set -U fish_history ""
set -U fish_user_paths
set -x BROWSER "waterfox"

fish_default_key_bindings

source ~/.aliases.sh

# Start X at login
if status --is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end
