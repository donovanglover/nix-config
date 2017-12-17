##################################################################################
#
#    New Start: A modern Arch workflow built with an emphasis on functionality.
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

# TODO: If --release then add --release to the build command
#if [ $1 = "release" ]; then
#    echo "release"
#fi

# TODO: If a filename is given, build only that file and not all the files
# i.e. './build.sh maid' only builds src/maid.cr

# Build each and every file in src/, placing the output in bin/
for file in src/*.cr; do
    f=${file#"src/"}
    f=${f%".cr"}
    crystal build src/$f.cr -o bin/$f && echo "Successfully built src/$f.cr"
done
