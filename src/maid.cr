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

    UPSTREAM = "/Home/new-start/dotfiles"

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
            else Maid.unknown()
        end
    end

    def help()
        puts Trucolor.format({125, 255, 0}, "Usage: maid [command]")
        _hr("Always used:")
        _hc("up", "Replace the file upstream with the file downstream")
        _hc("down", "Replace the file downstream with the file upstream")
        _hc("status", "List the files that aren't in sync with upstream")
        _hr("Sometimes used:")
        _hc("diff", "View the lines that differ between upstream and downstream")
        _hr("Rarely used:")
        _hc("add", "Copy a file from downstream to upstream")
        _hc("remove", "Removes a file from upstream, preventing it from being tracked")
        _hn("Ideally you should only edit files locally (i.e. not upstream)")
        _hn("Then pushing your changes is as simple as typing 'maid up'!")
        exit 0
    end

    private def _hc(command, description)
        puts Trucolor.format({255, 55, 225}, "    #{command.ljust(14, ' ')}#{description}")
    end

    private def _hr(message)
        puts Trucolor.format({12, 155, 255}, "  #{message}")
    end

    private def _hn(note)
        puts Trucolor.format({255, 128, 10}, "#{note}")
    end

    def unknown()
        puts Trucolor.format({255, 55, 20}, "Unknown command '#{ARGV[0]}'")
        puts Trucolor.format({200, 200, 10}, "Type 'maid help' for a list of commands")
        exit 1
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
        # For each file in upstream
        Dir.glob(ENV["HOME"] + Maid::UPSTREAM + "/**/*").each do |upstream|
            next if File.directory?(upstream)
            downstream = upstream.sub(UPSTREAM, "")
            puts Trucolor.format({180, 0, 255}, upstream.sub(ENV["HOME"], "~")) + " -> " + Trucolor.format({255, 0, 128}, downstream.sub(ENV["HOME"], "~"))
            # If the file upstream exists downstream
            if File.exists?(downstream)
                # Print a summary of what's different if they aren't the same
                unless upstream.includes?(".jpg") || FileUtils.cmp(upstream, downstream)
                    puts "Lines in the upstream repository but not stored locally:"
                    puts Trucolor.format({20, 200, 255}, `grep -nFxvf #{upstream} #{downstream}`)
                    puts "Lines stored locally but not upstream:"
                    puts Trucolor.format({255, 200, 58}, `grep -nFxvf #{downstream} #{upstream}`)
                end
            end
        end
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

    private def _e(error)
        puts Trucolor.format({255, 55, 20}, error)
    end

    def remove()
        puts "Remove"
        exit 0
    end

end

Maid.maid()
