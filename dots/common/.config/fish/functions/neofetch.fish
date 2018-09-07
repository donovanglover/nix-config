function neofetch
    echo -ne '\n'
    /usr/bin/neofetch \
        --disable \
            model gpu wm_theme theme icons \
            line_break cols kernel \
        --ascii_distro linux \
        --package_managers off \
        --os_arch off \
        --speed_shorthand on \
        --cpu_brand off \
        --cpu_cores off
end
