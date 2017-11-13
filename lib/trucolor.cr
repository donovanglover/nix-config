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

module Trucolor
    # Formats a string *str* with the colors given in the turple *rgb* (0 <= rgb[i] <= 255)
    def self.format(rgb, str)
        return "\x1b[38;2;#{rgb[0]};#{rgb[1]};#{rgb[2]}m#{str}\x1b[0m"
    end
    
    # Goes through the colors in such a way that only 256 colors are used (0 <= n <= 255)
    # @requires self.format()
    def self.rainbow(n)
        h = n / 43
        f = n - 43 * h
        t = f * 255 / 43
        q = 255 - t
        
        case h
        when 0
            return {255, t, 0}
        when 1
            return {q, 255, 0}
        when 2
            return {0, 255, t}
        when 3
            return {0, q, 255}
        when 4
            return {t, 0, 255}
        when 5
            return {255, 0, q}
        else
            return {0, 0, 0}
        end

    end
    
    # Tests the format method by printing a rainbow of colors
    # @requires self.rainbow()
    def self.test()
        n = -1
        while (n += 1) < 256
           print self.format(self.rainbow(n), "#{n}".rjust(3, '0')) + " "
           print "\n" if (n + 1) % 16 == 0
        end
    end

end

