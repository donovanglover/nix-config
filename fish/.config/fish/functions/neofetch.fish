function neofetch
    echo -ne '\n'
    /usr/bin/neofetch \
        --disable cpu model gpu kernel \
        --shell_version off \
        --os_arch off \
        --gtk_shorthand on \
        --gtk2 off \
        --gtk3 off \
        --package_managers off \
        --uptime_shorthand tiny \
        --block_range 1 7 \
        --bar_char '~' '-' \
        --bar_border off \
        --bar_colors 6 7 \
        --bar_length 11 \
        --memory_display bar \
        --loop \
        --size 48% \
        --w3m \
        $argv
end
