##################################################################################
#
#    New Start: A modern Arch workflow built with an emphasis on functionality.
#    Copyright (C) 2017 Donovan Glover
#    
#    Trufetch: A colorful fetch script inspired by neofetch
#    Copyright (C) 2017 Donovan Glover
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.
#
##################################################################################

# Trufetch is an alternative to neofetch that emphasizes the use of true color support
# It is made specifically for this system and does not rely on many external calls

require "../lib/trucolor"

module Trufetch
    extend self

    def trufetch()
        Trufetch.fetch() if ARGV.size() == 0
        case ARGV[0].delete("-")
            when "help", "h"; Trufetch.help()
            else Trufetch.unknown()
        end
    end

    def fetch()
        # These values are queried manually since they change often
        uptime = `uptime -p`.lchop("up ").split(",")
        packages = `pacman -Qq --color never | wc -l`
        resolution = `xrandr | grep '*'`.split('"')[1].split('_')[0]

        add_banner("New Start")
        add("OS",               "GNU/Linux (Arch)")

        # TODO: Test this with different inputs
        # TODO: Handle the edge case where there's only one item
        add("Uptime",           uptime[0] + "," + uptime[1])

        add("Packages",         packages) 
        add("Shell",            "zsh")
        add("Resolution",       resolution)
        add("Window Manager",   "i3-gaps")
        add("Terminal",         "termite")
        add("Fonts",            "Noto, Hack")
        exit 0
    end

    def help()
        puts "Help"
        exit 0
    end

    def unknown()
        puts "Unknown"
        exit 0
    end

    def add(section, contents)
        message = section + ": " + contents
        puts message
    end

    def add_banner(text)
        puts text
    end

end

Trufetch.trufetch()

