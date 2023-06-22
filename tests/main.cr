require "spec"
require "./check_top_level_imports"
require "./check_latest_commit"

check_top_level_imports("modules")
check_top_level_imports("overlays")
check_top_level_imports("home")

describe "./overlays/joshuto/default.nix", tags: "online" do
  it "uses the latest joshuto commit" do
    check_latest_commit("kamiyaa/joshuto", branch: "main")
  end
end

describe "./overlays/rofi/default.nix", tags: "online" do
  it "uses the latest rofi-wayland commit" do
    check_latest_commit("lbonn/rofi", branch: "wayland")
  end
end
