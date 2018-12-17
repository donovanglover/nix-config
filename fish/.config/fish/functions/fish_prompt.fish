# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

function fish_prompt

    # Use a more informative and non-unicode prompt for ttys
    if status --is-login; and test -z "$DISPLAY"
        set hostname (hostname)

        set_color yellow;   echo -n "$USER@$hostname"
        set_color normal;   echo -n " "
        set_color magenta;  echo -n "($PWD)"
    else
        set pwd (basename $PWD)
        set branch (git branch ^/dev/null | sed -n '/\* /s///p')

        if [ $pwd = $USER ]
            set pwd "~"
        end

        set_color magenta;  echo -n "$pwd"

        if [ "$branch" ]
            set_color normal;   echo -n " on "
            set_color yellow;   echo -n "$branch"

            set tag (git describe ^/dev/null | sed 's/-\w*$//')

            if [ "$tag" ]
                set_color normal;   echo -n "/"
                set_color cyan;     echo -n "$tag"
            end
        end

        set_color normal;   echo -n " "
        set_color red;      echo -n "➤"
        set_color green;    echo -n "➤"
        set_color blue;     echo -n "➤"
    end

    set_color normal;   echo -n " "
end
