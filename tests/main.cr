require "spec"
require "colorize"
require "http/client"
require "json"

hint = ""

describe "./modules/default.nix" do
  it "imports all modules" do
    all_modules = Dir.children("modules")
    all_modules.delete("default.nix")
    modules = File.read("./modules/default.nix")

    all_modules.each do |current_module|
      hint = "Missing ./#{current_module} import in ./modules/default.nix."
      modules.includes?("./#{current_module}").should be_true
    end

    hint = ""
  end
end

describe "./overlays/joshuto/default.nix" do
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

Spec.after_suite do
  if !hint.empty?
    puts "✗ #{hint}".colorize(:yellow)
  end
end
