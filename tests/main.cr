require "spec"
require "./check_top_level_imports"
require "./check_latest_commit"

check_top_level_imports("containers")
check_top_level_imports("home")
check_top_level_imports("modules")
check_top_level_imports("overlays")
check_top_level_imports("specializations")
