set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch magenta

set __fish_git_prompt_char_dirtystate '! '
set __fish_git_prompt_char_stagedstate '→ '
set __fish_git_prompt_char_stashstate '↩ '
set __fish_git_prompt_char_upstream_ahead '↑ '
set __fish_git_prompt_char_upstream_behind '↓ '

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

    set git (__fish_git_prompt)
    # $USER@$host
    echo -n "$pwd$git ➤➤➤ "
    # printf '%s@%s %s%s%s%s> ' (whoami) (hostname) (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) (__fish_git_prompt)
end
