require "spec"
require "colorize"

hint = ""

def check_top_level_imports(directory)
  describe "./#{directory}/default.nix" do
    it "imports all modules in ./#{directory}/", tags: "local" do
      all_modules = Dir.children(directory)
      all_modules.delete("default.nix")
      modules = File.read("./#{directory}/default.nix")

      all_modules.each do |current_module|
        hint = "Missing ./#{current_module} import in ./#{directory}/default.nix."
        modules.includes?("./#{current_module}").should be_true
      end

      hint = ""
    end

    it "only imports modules that exist in ./#{directory}/", tags: "local" do
      all_modules = Dir.children(directory)
      all_modules.delete("default.nix")

      File.each_line("./#{directory}/default.nix") do |line|
        if line.includes? "./"
          imported_file = line.lstrip(' ').lstrip("./")
          hint = "./#{imported_file} was imported but doesn't exist in directory ./#{directory}/."
          all_modules.includes?(imported_file).should be_true
        end
      end

      hint = ""
    end
  end
end

Spec.after_suite do
  hint.empty? || puts "✗ #{hint}".colorize(:yellow)
end
