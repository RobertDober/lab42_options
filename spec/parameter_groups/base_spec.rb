require 'spec_helper'

describe Lab42::Options do 
  context :implict do
    subject do
      Lab42::Options.new sub: :substitution, with: :substitution
    end
    context "get the groups" do 
      it 'yields one' do
        expect( subject.parameter_groups ).to have(1).element
      end
    end # context "get the groups"

    context "the parameter group" do 
      let(:pg){ subject.parameter_groups[ :substitution ] }
      
      it "has the names" do
        expect( pg.elements ).to eq [ pg[:sub], pg[:with] ]
      end
      it "has the basic information" do
        expect( pg[:sub].default ).to be_nil
        expect( pg[:sub] ).not_to have_default
      end
    end # context "the parameter group"

    context "legal values" do 
      it "can be empty" do
        expect( subject.parse([]).substitution ).to be_empty
      end

      it "can have correct values", :wip do
        expect( subject.parse( %w{sub: a with: b sub: c with: d} ).substitution ).to eq [{sub: "a", with: "b"}, {sub: "c", with: "d"}]
      end
    end # context "legal values"
  end
end # describe Options

