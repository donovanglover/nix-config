require "fileutils"
require "../lib/trucolor"

UPSTREAM = "/Home/new-start/dotfiles"

Dir.glob(ENV["HOME"] + UPSTREAM + "/**/*", File::FNM_DOTMATCH).each do |file|
    next if File.directory?(file)
    puts file
    a = file.sub(UPSTREAM, "")
    if File.exists?(a) then
        print "Are the two files identical? "
        identical = FileUtils.compare_file(file, a)
        print identical
        print "\n"

        if not identical and not file.include?(".jpg")
            puts `grep -nFxvf #{file} #{a}`
            puts `grep -nFxvf #{a} #{file}`
        end

    else
        puts "a did not exist."
    end
end
