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

require "./trucolor"

def fetch()
    uptime = `uptime -p`.lchop("up ").split(",")
    packages = `pacman -Qq --color never | wc -l`
    resolution = `xrandr | grep '*'`.split('"')[1].split('_')[0]
    kernel = `uname -r`
    os = `uname -o`.chomp()
    type = `uname -m`
    zsh_version = `zsh --version`.split(" ")[1]

    # add_banner("New Start")
    # TODO: Test this with different inputs
    # TODO: Handle the edge case where there's only one item
    puts ""
    puts add("OS", "Parabola #{os} #{type}")
    puts add("Kernel",           kernel)
    puts add("Uptime",           uptime[0] + "," + uptime[1])
    puts add("Packages",         packages)
    puts add("Shell",            "zsh #{zsh_version}")
    puts add("Resolution",       resolution)
    puts add("WM",   "i3-gaps")
    puts add("Terminal",         "termite")
    puts add("Terminal Font",            "Hack")
    puts ""
end

def add(section, contents)
    return Trucolor.format({255, 0, 128}, section) + ": " + contents
end

def add_banner(text)
    puts text
    puts "-" * text.size()
end

fetch()
