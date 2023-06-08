require "spec"
require "colorize"
require "http/client"
require "json"

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

  it "uses the latest joshuto commit" do
    response = HTTP::Client.get "https://api.github.com/repos/kamiyaa/joshuto/branches/main"
    response.status_code.should eq(200)
    json = JSON.parse(response.body)

    File.read_lines("./overlays/joshuto/default.nix").each do |line|
      if line.includes? "version ="
        nix_hash = line.split('"')[1]
        json["commit"]["sha"].should eq(nix_hash)
      end
    end
  end
end
