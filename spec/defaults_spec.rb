require 'spec_helper'

shared_examples "a helper" do
  it "returns the correct help text" do
    expect( options.get_help_text ).to match( /a: defaults to 43/ )
    expect( options.get_help_text ).to match( /b: required/ )
  end
end # shared_examples "a helper"

describe Lab42::Options do

  context "default help test" do 
    let(:options){Lab42::Options.new( a: 43, b: :required).strict(false)}
    context "with -h" do 
      before do
        options.parse( %W{-h} )
      end
      it_behaves_like "a helper"
    end # context "with --help"
    context "with --help" do 
      before do
        options.parse( %W{--help} )
      end
      it_behaves_like "a helper"
    end # context "with --help"
    context "with :help" do 
      before do
        options.parse( %W{:help} )
      end
      it_behaves_like "a helper"
    end # context "with :help"
  end # context "default help test"

  context "defined help text" do
    let(:options){ Lab42::Options.new a: 42, b: :required }

    it "shows an according help text" do
      options.define_help("The foo program").define_help_for(:b, 'is required and indicates the amount of bar')
      expect( options.get_help_text ).to match("The foo program")
      expect( options.get_help_text ).to match("a: defaults to 42")
      expect( options.get_help_text ).to match("b: is required and indicates the amount of bar")
    end

    it 'can use the default value when using a block' do
      options.define_help_for(:a){ |default|
        "the half of #{2*default}"
      }
      expect( options.get_help_text ).to match("a: defaults to the half of 84")
      
    end

  end # context "defined help text"

end # describe Lab42::Options
