require "spec"
require "colorize"

describe "nix-config" do
  it "includes all modules" do
    all_modules = Dir.children("modules")
    all_modules.delete("default.nix")
    modules = File.read("./modules/default.nix")

    all_modules.each do |current_module|
      print "Checking ./modules/#{current_module}...".colorize(:blue)
      modules.includes?("./#{current_module}").should be_true
      puts "✓".colorize(:green)
    end
  end
end
