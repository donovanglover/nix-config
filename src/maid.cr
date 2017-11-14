##################################################################################
#
#    New Start: A modern Arch workflow built with an emphasis on functionality.
#    Copyright (C) 2017 Donovan Glover
#    
#    Maid: Easily move dotfiles from one location to another
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

# Maid is a command line interface to handle the process of moving dotfiles from one
# location to another (i.e. between your local filesystem and the upstream repository)

# NOTE: For Maid to recognize the dotfiles you want, they must be in upstream first
# Use maid add <FULL_PATH> to add a dotfile to upstream (e.g. maid add ~/.vimrc)

# TODO: Use .maidrc to store configuration (?)
# If so, add Maid.init() to create a base configuration

require "file_utils"
require "../lib/trucolor"

module Maid
    UPSTREAM = ENV["HOME"] + "/Home/new-start/dotfiles"

    extend self

    def maid()
        Maid.status() if ARGV.size() == 0
        case ARGV[0].delete("-")
            when "help",    "h"; Maid.help()
            when "up",      "u"; Maid.up()
            when "down",    "d"; Maid.down()
            when "status",  "s"; Maid.status()
            when "diff",    "f"; Maid.diff()
            when "add",     "a"; Maid.add()
            when "remove",  "r"; Maid.remove()
        end
    end

    def help()
        puts "Help"
        exit 0
    end

    def up()
        puts "Up"
        exit 0
    end

    def down()
        puts "Down"
        exit 0
    end
    
    def status()
        puts "Status"
        exit 0
    end

    def diff()
        puts "Diff"
        exit 0
    end

    def add()
        puts "Add"
        exit 0
    end

    def remove()
        puts "Remove"
        exit 0
    end

end

Maid.maid()
