require 'spec_helper'

describe Lab42::Options do 
  context "implicit group" do
    subject do
      described_class.new sub: :substitution, with: :substitution
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
        expect( subject.parse([]).groups.substitution ).to be_empty
      end

      it "can have correct values" do
        expect( subject.parse( %w{sub: a with: b sub: c with: d} ).groups.substitution ).to eq [{sub: "a", with: "b"}, {sub: "c", with: "d"}]
      end
    end # context "legal values"
  end

  context "explicit group" do
    subject do
      described_class
        .new
        .group :substitution do | sub |
          sub.element :sub
          sub.element :with, :optional
        end
    end
    context "the group" do 
      let(:pg){ subject.parameter_groups[ :substitution ] }
      it "has the names" do
        expect( pg.elements ).to eq [ pg[:sub], pg[:with] ]
      end
      it "has the basic information" do
        expect( pg[:sub].default ).to be_nil
        expect( pg[:sub] ).not_to have_default
      end
      it "has the basic information with default" do
        expect( pg[:with].default ).to be_nil
        expect( pg[:with] ).to have_default
      end
      
    end # context "the group"
  end # context :explicit
end # describe Options

