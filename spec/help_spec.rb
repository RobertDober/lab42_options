require 'spec_helper'

describe Lab42::Options do 
  context "required arguments" do
    let(:options){Lab42::Options.new a: :required}
    context "provided" do 
      it "will be ok if a is provided as a key, value pair" do
        expect( options.parse(*%W{a: 42}).a ).to eq("42")
      end
      it "will be ok if a is provided as a switch" do
        expect( options.parse(*%W{:a}).a ).to eq(true)
      end
    end # context "provided"context"
    context "not provided" do 
      it "errors for no args at all" do
        expect( ->{ options.parse() } ).to raise_error
      end
      it "errors for different args" do
        expect( ->{ options.parse(*%W{:b c: 42}) } ).to raise_error
      end
    end # context "not provided"
  end # context "required arguments"
end # describe Lab42::Options
