require 'spec_helper'

def it_is_valid bool
  if bool
    it "is valid" do
      expect( validator ).to be_valid
    end
  else
    it "is not valid" do
      expect( validator ).not_to be_valid
    end
  end
end

def it_has_spurious params
  it "has spurious #{params.inspect}" do
    expect( validator.spurious ).to eq( params )
  end
end

def it_has_missing params
  it "has missing #{params.inspect}" do
    expect( validator.missing ).to eq( params )
  end
end

describe Lab42::Options::Validator, :wip do
  context 'spurious' do 
    let(:validator){
      described_class.new a: true, b: 42, c: :required
    }


    context 'everything is fine' do 
      before do
        validator.validate c: "hello"
      end
      it_is_valid true
      it_has_missing( {} )
      it_has_spurious( {} )
    end # context 'everything is fine'
    
    context "required missing" do 
      before do
        validator.validate a: 42, b: true
      end
      
    end # context "required missing"

    context "spurious" do 
      
    end # context "spurious"

    context "required missing and spurious" do 
      
    end # context "required missing and spurious"
    
  end # context 'spurious'
  
end # describe Lab42::Options::Validator
