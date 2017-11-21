##################################################################################
#
#    New Start: A modern Arch workflow built with an emphasis on functionality.
#    Copyright (C) 2017 Donovan Glover
#    
#    Pass: A very simple and straight-forward password manager
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

# Pass lets you easily retrieve passwords and other sensitive information.
# Please do not confuse this pass with the standard pass utility.

# Placeholder for the library we create to handle the plain text file format
require "txt"

require "trucolor"

module Pass
    extend self

    def pass()
        Pass.status() if ARGV.size() == 0
        case ARGV[0].delete("-")
            when "get";     Pass.get()
            when "status";  Pass.status()
            when "help";    Pass.help()
            when "add";     Pass.add()
            when "remove";  Pass.remove()
            when "list";    Pass.list()
            when "update";  Pass.update()
            when "gen";     Pass.gen()
            when "new";     Pass._new()
            else Pass.unknown()
        end
    end

    def help()
        puts "Help"
        exit 0
    end

    def unknown()
        puts "Unknown"
        exit 1
    end

    # Show statistics about password usage such as the number of passwords,
    # the length of the shortest password and the length of the longest password
    # Show information about any passwords that haven't been changed in a while
    # TODO: Allow the user to define how long before this notice appears?
    def status()
        puts "Status"
        exit 0
    end

    # Get the password for a specific service
    # TODO: Allow the user to get other things as well (e.g. username) by explicitly specifying it?
    def get()
        puts "Get"
        exit 0
    end

    # Add a new username / password combination to pass, allowing the user to specify
    # other information as well, such as domain(s)
    def add()
        puts "Add"
        exit 0
    end

    # Remove a specific service from the password manager
    # NOTE: This may not work for multiple accounts on the same domain, depending on whether
    # or not this is a feature worth implementing
    def remove()
        puts "Remove"
        exit 0
    end

    # Shows all the services in the database but not their passwords
    # TODO: Enable a user to create their own lists by using [Brackets] (?)
    # If so, make these lists accessible through pass list <name>
    def list()
        puts "List"
        exit 0
    end

    # Update an existing password with a new password
    # TODO: Decide whether you prefer `pass update` or `pass up` for this task
    def update()
        puts "Update"
        exit 0
    end

    # Generate a new password
    # TODO: Decide whether or not `pass gen` should simply generate a password
    # or save it as well (maybe another method would be better for this)
    def gen()
        puts "Gen"
        exit 0
    end

    # Add a new service with an automatically generated password
    # TODO: The user must (?) specify the username and domain(s)
    # TODO (?): Find a better name than _new() since new is a reserved word
    # TODO (?): Make Passwords their own class (ideally they should extend from "TextItems")
    def _new()
        puts "New"
        exit 0
    end
end

Pass.pass()

