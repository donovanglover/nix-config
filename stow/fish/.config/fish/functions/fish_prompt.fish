function fish_prompt
    set -l color_cwd
    set -l suffix
    set host (prompt_hostname)
    set pwd (basename $PWD)
    if [ $pwd = $USER ]
        set pwd "~"
    end
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix ""
    end

    # $USER@$host
    echo -n "$pwd ➤➤➤ "
end

