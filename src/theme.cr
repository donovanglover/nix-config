require "theme"
require "yaml"

if ARGV.size > 0
  file : String = ARGV[0]
  Theme._DNE(file) if !File.exists?(file)

  if File.extname(file) != ".yaml" && File.extname(file) != ".yml"
    Theme._e("The file #{File.expand_path(file)} doesn't appear to be .yaml!")
  end

  theme : Hash(YAML::Type, YAML::Type) = YAML.parse(File.read file).as_h

  Theme.set_terminal(theme)
  puts "Successfully changed the theme to #{theme["scheme"].to_s}!"
else
  Theme.test
end
