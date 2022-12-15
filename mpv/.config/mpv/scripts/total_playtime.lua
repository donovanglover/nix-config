-- MIT License
--
-- Copyright (c) 2018 oltodosel
--
-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:
--
-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.
--
-- Original: https://github.com/oltodosel/mpv-scripts/blob/master/total_playtime.lua
--
--~ Shows total playtime of current playlist.
--~ If number of items in playlist didn't change since last calculation - it doesn't probe files anew.
--~ requires ffprobe (ffmpeg)

key_binding = 'F12'
-- save probed files for future reference -- ${fname} \t ${duration}
save_probed = true
saved_probed_filename = '/tmp/mpv_total_playtime.list'

-----------------------------------

saved_probed_filename = saved_probed_filename:gsub('~', os.getenv('HOME'))

local utils = require 'mp.utils'

function disp_time(time)
  local hours = math.floor(time/3600)
  local minutes = math.floor((time % 3600)/60)
  local seconds = math.floor(time % 60)

  return string.format("%02d:%02d:%02d", hours, minutes, seconds)
end

function setContains(set, key)
  return set[key] ~= nil
end
playlist = {}
playlist_total = -1

function total_time()
  if #playlist ~= playlist_total then
    if save_probed then
      if io.open(saved_probed_filename, "rb") then
        probed_file = {}
        for line in io.lines(saved_probed_filename) do
          for k, v in line:gmatch("(.+)\t(.+)") do
            probed_file[k] = v
          end
        end
      else
        probed_file = {}
      end
    end

    local cwd = utils.getcwd()
    for pl_num, f in ipairs(mp.get_property_native("playlist")) do
      f = utils.join_path(cwd, f.filename)
      -- attempt basic path normalization
      if on_windows then
        f = string.gsub(f, "\\", "/")
      end
      f = string.gsub(f, "/%./", "/")
      local n
      repeat
        f, n = string.gsub(f, "/[^/]*/%.%./", "/", 1)
      until n == 0

      f = string.gsub(f, "\"", "\\\"")

      if save_probed and probed_file[f] then
        fprobe = probed_file[f]
      else
        fprobe = io.popen('ffprobe -v quiet -of csv=p=0 -show_entries format=duration "'.. f .. '"'):read()

        if fprobe and save_probed then
          file = io.open(saved_probed_filename, "a")
          file:write(f .. '\t' .. fprobe .."\n")
          file:close()
        end
      end

      playlist[#playlist + 1] = { f, tonumber(fprobe), pl_num }

      mp.osd_message(string.format("Calculating: %s/%s", #playlist, mp.get_property("playlist-count")))
    end
    playlist_total = #playlist
  end

  total_dur = 0
  played_dur = mp.get_property_number("time-pos")
  current_pos = mp.get_property_number("playlist-pos-1", 0)

  for i, fn in pairs(playlist) do
    if fn[2] ~= nil then
      total_dur = total_dur + fn[2]
      if i < current_pos then
        played_dur = played_dur + fn[2]
      end
    end
  end

  mp.osd_message(string.format("%s/%s (%s%%) \n %s/%s", disp_time(played_dur), disp_time(total_dur), math.floor(played_dur*100/total_dur), mp.get_property("playlist-pos-1"), mp.get_property("playlist-count")))
end

mp.add_forced_key_binding(key_binding, "total_time", total_time)

--------------------------------------------------
--------------------------------------------------
--------------------------------------------------

function sort_playlist_to_0()
  sort_playlist(1)
end

reverse = 0
function sort_playlist(start_0)
  total_time()

  table.sort(playlist, function (left, right)
    if reverse == 0 then
      return left[2] < right[2]
    else
      return left[2] > right[2]
    end
  end)

  if reverse == 0 then
    reverse = 1
  else
    reverse = 0
  end

  out = ''

  for i, f in pairs(playlist) do
    if f[2] ~= nil then
      for i2, f2 in ipairs(mp.get_property_native("playlist")) do
        if f2.filename == f[1] then
          mp.commandv('playlist-move', i2 - 1, i - 1)

          if f2.filename == mp.get_property("path") then
            -- out = string.format('%s>>%s\t\t%s\n', out, disp_time(f[2]), f[1]:gsub('.+/', ''))
            out = string.format('%s%s\t\t%s\n', out, disp_time(f[2]), f[1]:gsub('.+/', ''))
          else
            out = string.format('%s%s\t\t%s\n', out, disp_time(f[2]), f[1]:gsub('.+/', ''))
          end
          break
        end
      end
    end
  end

  if start_0 ~= nil then
    mp.set_property('playlist-pos', 0)
    os.execute('sleep .1')
  end
  mp.osd_message(out, 3)
end

mp.add_forced_key_binding('KP4', "sort_playlist", sort_playlist)
mp.add_forced_key_binding('shift+KP4', "sort_playlist_to_0", sort_playlist_to_0)
