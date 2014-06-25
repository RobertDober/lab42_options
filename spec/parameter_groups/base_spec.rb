require 'spec_helper'

describe Lab42::Options, :wip do 
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
        expect( pg.names ).to eq [:sub, :width]
      end
      it "has the basic information" do
        expect( pg[:sub].default ).to be_nil
        expect( pg[:sub].has_default? ).to be_false
      end
    end # context "the parameter group"

  end
end # describe Options

