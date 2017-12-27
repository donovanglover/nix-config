require "colorize"

module Theme
  extend self

  # Prints the colors of the theme in the current shell.
  #
  # Useful when you want to see all the colors of the
  # theme that you're using.
  #
  # NOTE: This method does not change any colors. You should use
  #       another method like #set_terminal to change colors first.
  #
  # NOTE: Although most (if not all) Base16 themes follow the
  #       color specification exactly, you should by no means
  #       use a color combination if it doesn't work well with
  #       other programs. An example of where you'd want to
  #       carefully pick your colors is for the man pages,
  #       where the bottom text is yellow on cyan.
  #
  # TODO: In the future, it may be best to add edge cases to
  #       the #test method to ensure everything looks nice.
  #
  # TODO: It may also help to add a description of what these
  #       colors will affect in addition to the terminal
  #       (e.g. i3 borders, polybar text, etc.)
  def test
    #test_color :black,          "color21 base06"
    test_color :red,            "color01 base08"
    test_color :green,          "color02 base0B"
    test_color :yellow,         "color03 base0A"
    test_color :blue,           "color04 base0D"
    test_color :magenta,        "color05 base0E"
    test_color :cyan,           "color06 base0C"
    # Note that color07 and color08 aren't the real numbers here
    # The same applies for their respective base values
    test_color :light_gray,     "color07 base01"
    test_color :dark_gray,      "color08 base03"
    #test_color :light_red,      "color09 base08"
    #test_color :light_green,    "color10 base0B"
    #test_color :light_yellow,   "color11 base0A"
    #test_color :light_blue,     "color12 base0D"
    #test_color :light_magenta,  "color13 base0E"
    #test_color :light_cyan,     "color14 base0C"
    #test_color :white,          "color07 base05"
  end

  # Sets all the colors in .Xresources, then reloads xrdb.
  #
  # This method will replace everything after the `[colors]`
  # line with the theme colors, then reload xrdb to make sure
  # that everything takes effect.
  #
  # You should reload i3 (which in turn should reload polybar)
  # if you want the changes to take effect immediately.
  def set_xresources(theme : Hash(YAML::Type, YAML::Type))
    file : String = ENV["HOME"] + "/.Xresources"
    _DNE(file) if !File.exists?(file)
    config : String = ""
    File.each_line(file) do |line|
      config += line + "\n"
      break if line.includes?("[colors]")
    end
    config += add_xcolor_fgbg "foreground",  theme["base05"]
    config += add_xcolor_fgbg "cursorColor", theme["base06"]
    config += add_xcolor_fgbg "background",  theme["base00"]
    config += add_xcolor  0,  theme["base00"] # Black
    config += add_xcolor  8,  theme["base03"] # Gray
    config += add_xcolor  7,  theme["base05"] # Silver
    config += add_xcolor 15,  theme["base07"] # White
    config += add_xcolor  1,  theme["base08"] # Red
    config += add_xcolor  9,  theme["base08"]
    config += add_xcolor  2,  theme["base0B"] # Green
    config += add_xcolor 10,  theme["base0B"]
    config += add_xcolor  3,  theme["base0A"] # Yellow
    config += add_xcolor 11,  theme["base0A"]
    config += add_xcolor  4,  theme["base0D"] # Blue
    config += add_xcolor 12,  theme["base0D"]
    config += add_xcolor  5,  theme["base0E"] # Purple
    config += add_xcolor 13,  theme["base0E"]
    config += add_xcolor  6,  theme["base0C"] # Teal
    config += add_xcolor 14,  theme["base0C"]
    config += add_xcolor 16,  theme["base09"] # "Extra" colors
    config += add_xcolor 17,  theme["base0F"]
    config += add_xcolor 18,  theme["base01"]
    config += add_xcolor 19,  theme["base02"]
    config += add_xcolor 20,  theme["base04"]
    config += add_xcolor 21,  theme["base06"]
    config += "\n! vim:ft=xdefaults\n"
    File.write(file, config)
    system("xrdb ~/.Xresources")
  end

  # Sets all the colors in termite.
  #
  # This is the preferred method of changing your terminal
  # colors. It also lets you avoid a few edge cases that
  # #set_back and #set_shell are prone to.
  #
  # The only downside to #set_terminal is that you have to
  # open a new window in order for the changes to take effect.
  #
  # It is also possible to have several windows open each
  # with different themes; however, you should really only
  # be using one theme at a time.
  #
  # NOTE: This method assumes that (1) `[colors]` is at the
  #       bottom of your config file. This method will
  #       overwrite all lines after the first line with
  #       the keyword `[colors]` in it.
  #
  # NOTE: This method assumes that you want `# vim:ft=dosini`
  #       at the bottom of your config file.
  def set_terminal(theme : Hash(YAML::Type, YAML::Type))
    file : String = ENV["HOME"] + "/.config/termite/config"
    _DNE(file) if !File.exists?(file)
    config : String = ""
    File.each_line(file) do |line|
      config += line + "\n"
      break if line.includes?("[colors]")
    end
    config += add_term_fgbg "foreground",         theme["base05"]
    config += add_term_fgbg "foreground_bold",    theme["base06"]
    config += add_term_fgbg "cursor",             theme["base06"]
    config += add_term_fgbg "cursor_foreground",  theme["base00"]
    config += add_term_fgbg "background",         theme["base00"]
    config += "\n"
    config += add_term  0,  theme["base00"] # Black
    config += add_term  8,  theme["base03"] # Gray
    config += add_term  7,  theme["base05"] # Silver
    config += add_term 15,  theme["base07"] # White
    config += add_term  1,  theme["base08"] # Red
    config += add_term  9,  theme["base08"]
    config += add_term  2,  theme["base0B"] # Green
    config += add_term 10,  theme["base0B"]
    config += add_term  3,  theme["base0A"] # Yellow
    config += add_term 11,  theme["base0A"]
    config += add_term  4,  theme["base0D"] # Blue
    config += add_term 12,  theme["base0D"]
    config += add_term  5,  theme["base0E"] # Purple
    config += add_term 13,  theme["base0E"]
    config += add_term  6,  theme["base0C"] # Teal
    config += add_term 14,  theme["base0C"]
    config += add_term 16,  theme["base09"] # "Extra" colors
    config += add_term 17,  theme["base0F"]
    config += add_term 18,  theme["base01"]
    config += add_term 19,  theme["base02"]
    config += add_term 20,  theme["base04"]
    config += add_term 21,  theme["base06"]
    config += "\n# vim:ft=dosini\n"
    File.write(file, config)
  end

  # Sets the background color in termite.
  #
  # NOTE: This is particularly useful to avoid color flashing.
  #       Color flashing occurs when the terminal background
  #       gets changed to a different color by the shell
  #       at startup.
  #
  # NOTE: You should avoid manually calling #set_back and
  #       #set_shell. Instead, you should use #set_terminal
  #       instead since it fixes a lot of edge cases.
  def set_back(theme : Hash(YAML::Type, YAML::Type))
    file : String = ENV["HOME"] + "/.config/termite/config"
    _DNE(file) if !File.exists?(file)
    config : String = ""
    File.each_line(file) do |line|
      if line.includes?("background = ")
        line = "background = #" + theme["base00"].to_s
      end
      config += line + "\n"
    end
    File.write(file, config)
  end

  # Sets the terminal colors in the current shell.
  #
  # NOTE: To make this apply for all terminals (shells) you
  #       open, simply call this method in each new instance.
  #       This is the traditional method used by base16-shell;
  #       however, it makes more sense to just change the
  #       config file directly and avoid having to call an
  #       external script every time you start a new terminal.
  #
  # NOTE: When using padding with terminals such as termite, the
  #       background color for the terminal will take priority
  #       over the background color for the shell. Therefore,
  #       if you're using termite with padding, you should avoid
  #       this method and simply use #set_terminal instead.
  #
  # NOTE: Another downside to using #set_shell is that colors
  #       will be reset by commands like `tput reset`. Note
  #       that #set_terminal does not have this issue.
  def set_shell(theme : Hash(YAML::Type, YAML::Type))
    _theme = theme.clone
    _theme.each do |key, value|
      _theme[key] = value.to_s.insert(4, '/').insert(2, '/')
    end
    add_color      0, _theme["base00"] # Black
    add_color      1, _theme["base08"] # Red
    add_color      2, _theme["base0B"] # Green
    add_color      3, _theme["base0A"] # Yellow
    add_color      4, _theme["base0D"] # Blue
    add_color      5, _theme["base0E"] # Magenta
    add_color      6, _theme["base0C"] # Cyan
    add_color      7, _theme["base05"] # White
    add_color      8, _theme["base03"] # Bright Black
    add_color      9, _theme["base08"] # Bright Red
    add_color     10, _theme["base0B"] # Bright Green
    add_color     11, _theme["base0A"] # Bright Yellow
    add_color     12, _theme["base0D"] # Bright Blue
    add_color     13, _theme["base0E"] # Bright Magenta
    add_color     14, _theme["base0C"] # Bright Cyan
    add_color     15, _theme["base07"] # Bright White
    add_color     16, _theme["base09"]
    add_color     17, _theme["base0F"]
    add_color     18, _theme["base01"]
    add_color     19, _theme["base02"]
    add_color     20, _theme["base04"]
    add_color     21, _theme["base06"]
    fgbg_color    10, _theme["base05"]
    fgbg_color    11, _theme["base00"]
    cursor_color  12, ";7"
  end

  private def add_color(num : Int32, color : YAML::Type)
    print "\033]4;#{num};rgb:#{color.to_s}\033\\"
  end

  private def fgbg_color(num : Int32, color : YAML::Type)
    print "\033]#{num};rgb:#{color.to_s}\033\\"
  end

  private def cursor_color(num : Int32, color : String)
    print "\033]#{num}#{color}\033\\"
  end

  private def test_color(color : Symbol, text : String)
    print text.colorize(color)
    print " "
    print "___________________________".colorize.fore(color).back(color)
    print "\n"
  end

  private def add_term(num : Int32, color : YAML::Type) : String
    return "color#{num.to_s.ljust(2, ' ')} = ##{color.to_s}\n"
  end

  private def add_term_fgbg(type : String, color : YAML::Type) : String
    return "#{type.ljust(17, ' ')} = ##{color.to_s}\n"
  end

  private def add_xcolor(num : Int32, color : YAML::Type) : String
    return "*color#{num.to_s}: ##{color.to_s}\n"
  end

  private def add_xcolor_fgbg(type : String, color : YAML::Type) : String
    return "*#{type}: ##{color.to_s}\n"
  end

  # Prints an error that the file does not exists.
  def _DNE(file : String)
    _e("The file " + File.expand_path(file) + " does not exist!")
  end

  def _e(message : String)
    puts message.colorize(:red)
    exit 1
  end
end
