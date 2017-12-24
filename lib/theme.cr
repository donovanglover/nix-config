require "colorize"

module Theme
  extend self

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
  # NOTE: This method assumes that (1) `[color]` is at the
  #       bottom of your config file. This method will
  #       overwrite all lines after the `[color]` line.
  #
  # NOTE: This method assumes that you want `# vim:ft=dosini`
  #       at the bottom of your config file.
  def set_terminal(theme : Hash(YAML::Type, YAML::Type))
    file : String = ENV["HOME"] + "/.config/termite/config"
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
  #       instead as this fixes a lot of edge cases.
  def set_back(theme : Hash(YAML::Type, YAML::Type))
    file : String = ENV["HOME"] + "/.config/termite/config"
    if !File.exists?(file)
      _e("The file " + File.expand_path(file) + " doesn't exist!")
    end
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
  def set_shell(t : Hash(YAML::Type, YAML::Type))
    theme = t.clone
    theme.each do |key, value|
      theme[key] = value.to_s.insert(4, '/').insert(2, '/')
    end
    add_color      0, theme["base00"] # Black
    add_color      1, theme["base08"] # Red
    add_color      2, theme["base0B"] # Green
    add_color      3, theme["base0A"] # Yellow
    add_color      4, theme["base0D"] # Blue
    add_color      5, theme["base0E"] # Magenta
    add_color      6, theme["base0C"] # Cyan
    add_color      7, theme["base05"] # White
    add_color      8, theme["base03"] # Bright Black
    add_color      9, theme["base08"] # Bright Red
    add_color     10, theme["base0B"] # Bright Green
    add_color     11, theme["base0A"] # Bright Yellow
    add_color     12, theme["base0D"] # Bright Blue
    add_color     13, theme["base0E"] # Bright Magenta
    add_color     14, theme["base0C"] # Bright Cyan
    add_color     15, theme["base07"] # Bright White
    add_color     16, theme["base09"]
    add_color     17, theme["base0F"]
    add_color     18, theme["base01"]
    add_color     19, theme["base02"]
    add_color     20, theme["base04"]
    add_color     21, theme["base06"]
    fgbg_color    10, theme["base05"]
    fgbg_color    11, theme["base00"]
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

  private def _e(message : String)
    puts message.colorize(:red)
    exit 1
  end
end
