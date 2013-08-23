require 'spec_helper'

describe Lab42::Options do 
  context "default arguments" do
    let(:options){Lab42::Options.new a: 43}
    context "provided" do 
      it "will be overwritten by a key value pair" do
        options.parse(*%W{a: 42}).a.should eq("42")
      end
      it "will be overwitten by a switch" do
        options.parse(*%W{:a}).a.should eq(true)
      end
    end
    context "not provided" do 
      it "will have the default value" do
        options.parse(*%W{b: 42}).a.should eq(43)
      end
    end # context "not provided"
  end # context "default arguments"
end # describe Lab42::Options
