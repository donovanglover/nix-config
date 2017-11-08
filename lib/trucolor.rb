#!/bin/ruby
##################################################################################
#
#    New Start: A modern Arch workflow built with an emphasis on functionality.
#    Copyright (C) 2017 Donovan Glover
#    
#    Trucolor: A library that makes colorful output trivial.
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

# TODO: Change script from simply testing output to a formal module

# Make the printed colors have the same size
def pad(num)
    return num.to_s.rjust(3, "0")
end

# Get the current rainbow color based on a number count (2^8)
def get_color(count)
    h = count / 43
    f = count - 43 * h
    t = f * 255 / 43
    q = 255 - t
    
    if h == 0 then
        r = 255; g = t; b = 0
    elsif h == 1 then
        r = q; g = 255; b = 0
    elsif h == 2 then
        r = 0; g = 255; b = t
    elsif h == 3 then
        r = 0; g = q; b = 255
    elsif h == 4 then
        r = t; g = 0; b = 255
    elsif h == 5 then
        r = 255; g = 0; b = q
    else
        r = 0; g = 0; b = 0
    end

    print "\x1b[38;2;#{r};#{g};#{b}m#{pad(r)},#{pad(g)},#{pad(b)}"
end

# Print a rainbow of colors, skipping over the majority of similar colors
count = 0

while count < 256 do
    
    if count % 16 == 0 and count != 0 then
        print "\n"
    end

    print get_color(count)
    
    print " "
    count = count + 1

end

print "\n"

# Print all the "pure red" colors
n = 0

while n < 256 do
    
    if n % 16 == 0 and n != 0 then
        print "\n"
    end

    print "\x1b[38;2;255;#{n};0m#{pad(n)}"
    
    print " "
    n = n + 1

end

def get_rgb_color(r, g, b)
    print "\x1b[38;2;#{r};#{g};#{b}m#{pad(r)},#{pad(g)},#{pad(b)}"
end

print "\n"

# Print a specific RGB value
get_rgb_color(255, 0, 128)

print "\x1b[0m\n"

