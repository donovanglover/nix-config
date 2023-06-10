require "spec"
require "./spec_helper"

check_top_level_imports("modules")

describe "./overlays/joshuto/default.nix" do
  it "uses the latest joshuto commit" do
    check_latest_commit("kamiyaa/joshuto", branch: "main")
  end
end

describe "./overlays/rofi/default.nix" do
  it "uses the latest rofi-wayland commit" do
    check_latest_commit("lbonn/rofi", branch: "wayland")
  end
end
