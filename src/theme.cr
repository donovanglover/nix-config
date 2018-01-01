require "./theme_helper"
require "yaml"

if ARGV.size > 0
  file : String = ARGV[0]
  Theme._DNE(file) if !File.exists?(file)

  if File.extname(file) != ".yaml" && File.extname(file) != ".yml"
    Theme._e("The file #{File.expand_path(file)} doesn't appear to be .yaml!")
  end

  theme : Hash(YAML::Type, YAML::Type) = YAML.parse(File.read file).as_h

  if ARGV.size > 1
    Theme.preview(theme)
  else
    Theme.set_terminal(theme)
    Theme.set_zathura(theme)
    Theme.set_xresources(theme)
    system("i3 restart >/dev/null 2>&1")
    puts "Successfully changed the theme to #{theme["scheme"].to_s}!"
  end

else
  Theme.test
end
