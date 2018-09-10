# New Start: A modern Arch workflow built with an emphasis on functionality.
# Copyright (C) 2017-2018 Donovan Glover

function fish_prompt
    set pwd (basename $PWD)
    set hostname (hostname)

    if [ $pwd = $USER ]
        set pwd "~"
    end

    set_color yellow;   echo -n "$USER@$hostname"
    set_color normal;   echo -n " "
    set_color magenta;  echo -n "($pwd)"
    #set_color magenta;  echo -n "$pwd"
    set_color normal;   echo -n " "
    set_color red;      echo -n "➤"
    set_color green;    echo -n "➤"
    set_color blue;     echo -n "➤"
    set_color normal;   echo -n " "
end
