require 'spec_helper'

describe Lab42::Options do 
  context "required arguments", :wip do
    let(:options){Lab42::Options.new a: :required}
    context "provided" do 
      it "will be ok if a is provided as a key, value pair" do
        options.parse(*%W{a: 42}).a.should eq("42")
      end
      it "will be ok if a is provided as a switch" do
        options.parse(*%W{:a}).a.should eq(true)
      end
    end # context "provided"context"
    context "not provided" do 
      it "errors for no args at all" do
        ->{ options.parse() }.should raise_error
      end
      it "errors for different args" do
        ->{ options.parse(*%W{:b c: 42}) }.should raise_error
      end
    end # context "not provided"
  end # context "required arguments"
end # describe Lab42::Options
