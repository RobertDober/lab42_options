require 'spec_helper'

describe Lab42::Options do 

    let(:options){
    Lab42::Options.new( a: :required, b: 42, c: nil )
  }

  context "strict set to", :wip do
    context "nil" do 
      before do
        options.strict( nil ) 
      end
      it "parses anything containing a: or :a" do
        expect( ->{
          options.parse( %W{ x: 52 :y a: 42 } )
        }).not_to raise_error

      end
    end # context "nil"

    context "warn" do 
      before do
        options.strict( :with_warnings ) 
      end
      it "parses anything containing a: or :a, but warns on spurious params" do
        $stderr.should_receive( :puts ).with( 'invalid parameter :x' )
        $stderr.should_receive( :puts ).with( 'invalid parameter :y' )
        expect( ->{
          options.parse( %W{ x: 52 :y a: 42 } )
        }).not_to raise_error

      end
    end # context "warn"

    context "error (default)" do 
      it "raises an error on spurious params" do
        expect( ->{
          options.parse( %W{ x: 52 :y a: 42 } )
        }).to raise_error( RuntimeError, "invalid parameters: :x, :y" )
      end

    end # context "true or strict"

  end # context "strict set to
  end # describe Lab42::Options
