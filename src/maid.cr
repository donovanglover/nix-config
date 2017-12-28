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
require "./trucolor"

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

    # 'maid up' will update all files upstream with the ones downstream
    # 'maid up <file>' to update a specific file
    def up()

        if ARGV.size == 1
            _e("You must specify the file to push to upstream.")
            exit 1
        end

        upstream = ENV["HOME"] + Maid::UPSTREAM + "/" + ARGV[1]
        downstream = ENV["HOME"] + "/" + ARGV[1]

        # Since we can't update the files upstream without knowing which ones to update,
        # we need to make sure that a downstream version exists as well as upstream
        # If you use 'maid up <file>' and the file does not exist, it will behave like 'maid add'
        if File.exists?(upstream) && File.exists?(downstream)
            unless FileUtils.cmp(upstream, downstream)
                File.write(upstream, File.read(downstream))
                if FileUtils.cmp(upstream, downstream)
                    puts "Successfully updated " + upstream.sub(ENV["HOME"], "~") + "!"
                else
                    puts "Uh oh. The files appear to still differ. This should never happen."
                end
            else
                puts "Both files exist, but they're the same, so there's no reason to update."
            end
        else
            puts "The file exists downstream but not upstream. Using 'maid add'."
        end

        exit 0

    end

    # 'maid down' will update all files downstream with the ones upstream
    # 'maid down <file>' to update a specific file
    def down()

        if ARGV.size == 1
            _e("You must specify the file to fetch from upstream.")
            exit 1
        end

        upstream = ENV["HOME"] + Maid::UPSTREAM + "/" + ARGV[1]
        downstream = ENV["HOME"] + "/" + ARGV[1]

        if File.exists?(upstream)
            if File.exists?(downstream) && !FileUtils.cmp(upstream, downstream)
                File.write(downstream, File.read(upstream))
                if FileUtils.cmp(upstream, downstream)
                    puts "Successfully updated " + downstream.sub(ENV["HOME"], "~") + "!"
                else
                    puts "Uh oh. The files appear to still differ. This should never happen."
                end
            else
                puts "Both files exist, but they're the same, so there's no reason to update."
            end
        else
            puts "The file must exist upstream before you can use it."
        end

        exit 0
    end

    def status()
        # For each file in upstream
        i = 0
        Dir.glob(ENV["HOME"] + Maid::UPSTREAM + "/**/*").each do |upstream|
            next if File.directory?(upstream)
            downstream = upstream.sub(UPSTREAM, "")
            # If the file downstream exists then print its name iff their contents differ
            # Otherwise state that the file upstream doesn't exist downstream
            o = downstream.sub(ENV["HOME"], "").lchop()
            if File.exists?(downstream)
                unless FileUtils.cmp(upstream, downstream)
                    puts "(#{i}) " + Trucolor.format({255, 0, 128}, o)
                    i = i + 1
                end
            else
                puts "(#{i}) " + Trucolor.format({255, 0, 255}, o)
                i = i + 1
            end
        end
        exit 0
    end

    def diff()

        if ARGV.size == 1
            _e("You must specify the file to view the difference between.")
            exit 1
        end

        upstream = ENV["HOME"] + Maid::UPSTREAM + "/" + ARGV[1]
        downstream = ENV["HOME"] + "/" + ARGV[1]
        # If the file exists downstream then print the diffference between upstream and downstream
        # Otherwise print that the file doesn't exist downstream
        if File.exists?(downstream)
            unless File.exists?(upstream)
                puts upstream.sub(ENV["HOME"], "~") + " does not exist."
                exit 1
            end
            unless FileUtils.cmp(upstream, downstream)
                puts "Lines downstream but not in the repository:"
                puts Trucolor.format({20, 150, 255}, `grep -nFxvf #{upstream} #{downstream}`)
                puts "Lines upstream but not stored locally:"
                puts Trucolor.format({155, 150, 58}, `grep -nFxvf #{downstream} #{upstream}`)
            else
                puts downstream.sub(ENV["HOME"], "").lchop() + " is already in sync."
            end
        else
            puts downstream.sub(ENV["HOME"], "~") + " does not exist."
            exit 1
        end
        exit 0

    end

    def add()

        if ARGV.size() == 1
            _e("You must specify a file to add to upstream")
            exit 1
        end

        # TODO: Make this logical instead of having multiple branching if statements
        downstream = ENV["HOME"] + "/" + ARGV[1]
        upstream = ENV["HOME"] + Maid::UPSTREAM + "/" + ARGV[1]
        if File.exists?(downstream)
            # If the file already exists upstream then throw an error
            # Otherwise add the file as usual
            if(File.exists?(upstream))
              _e("The file already exists upstream!")
              exit 1
            else
              # Make the directory upstream if it doesn't exist
              FileUtils.mkdir_p(upstream.rpartition('/')[0])
              File.write(upstream, File.read(downstream))
              if(File.exists?(upstream))
                puts "Successfully added " + upstream + "!"
              else
                puts "This should never happen. For some reason, " + upstream + " wasn't added."
              end
            end
        else
            puts "The file ~/" + ARGV[1] + " does not exist."
        end

        exit 0

    end

    private def _e(error)
        puts Trucolor.format({255, 55, 20}, error)
    end

    def remove()

        if ARGV.size() == 1
            _e("You must specify a file to remove from upstream")
            exit 1
        end

        if File.exists?(ENV["HOME"] + Maid::UPSTREAM + "/" + ARGV[1])
            puts "The file ~" + Maid::UPSTREAM + "/" + ARGV[1] + " exists."
            # TODO: Remove the file
        else
            puts "The file ~" + Maid::UPSTREAM + "/" + ARGV[1] + " does not exist."
        end

        exit 0

    end

end

Maid.maid()
