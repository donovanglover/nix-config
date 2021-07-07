# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2021 Donovan Glover

function fish_prompt

    # Use a more informative and non-unicode prompt for ttys
    if status --is-login; and test -z "$DISPLAY"
        set_color yellow;   echo -n "$USER@$hostname"
        set_color normal;   echo -n " "
        set_color magenta;  echo -n "($PWD)"
    else
        set pwd (basename $PWD)

        if [ $PWD = "/home/$USER" ]
            set pwd "~"
        end

        set_color magenta;  echo -n "$pwd"

        set_color normal;   echo -n " "
        set_color red;      echo -n "➤"
        set_color green;    echo -n "➤"
        set_color blue;     echo -n "➤"
    end

    set_color normal;   echo -n " "
end
