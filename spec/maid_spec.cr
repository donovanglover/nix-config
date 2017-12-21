require "spec"
require "../src/maid"

# Note that #up, #down, and #status share many of the same tests. This means that
# the "fail early" functionality should probably be abstracted into another method
# that all of the methods depend on

describe "Maid" do
    describe "#up" do
        it "should change the file upstream" do

        end

        it "should not change the file downstream" do

        end

        it "should not change anything if both files are the same" do

        end

        it "should fail early if the file upstream doesn't exist" do

        end

        it "should fail early if the file downstream doesn't exist" do

        end

        it "should fail early if the given argument isn't a file" do

        end
    end

    describe "#down" do
        it "should change the file downstream" do

        end

        it "should not change the file upstream" do

        end

        it "should not do anything if both files are the same" do

        end

        it "should fail early if the file upstream doesn't exist" do

        end

        it "should fail early if the file downstream doesn't exist" do

        end

        it "should fail early if the given argument isn't a file" do

        end
    end

    describe "#status" do
        it "should not modify the file upstream" do

        end

        it "should not modify the file downstream" do

        end

        it "should fail early if the file upstream doesn't exist" do

        end

        it "should fail early if the file downstream doesn't exist" do

        end

        it "should fail early if the given argument isn't a file" do

        end
    end
end

