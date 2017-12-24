require "theme"
require "yaml"
require "colorize"

Dir.cd(ENV["HOME"] + "/Home/new-start")

# Testing for now.
file : String = ARGV.size > 0 ? ARGV[0] : "themes/atelier-cave-light.yaml"

if !File.exists?(file)
  _e("The file " + File.expand_path(file) + " doesn't exist!")
end

yaml : Hash(YAML::Type, YAML::Type) = YAML.parse(File.read file).as_h

# Theme.set_terminal(yaml)
Theme.set_shell(yaml)
# Theme.set_back(yaml)

private def _e(message)
  puts message.colorize(:red)
  exit 1
end
