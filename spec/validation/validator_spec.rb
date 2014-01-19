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
  if params.empty?
    it "is not spurious" do
      expect( validator ).not_to be_spurious
    end
  else
    it "is spurious" do
      expect( validator ).to be_spurious
    end
  end
end

def it_has_missing params
  it "has missing #{params.inspect}" do
    expect( validator.missing ).to eq( params )
  end
  if params.empty?
    it "is not missing" do
      expect( validator ).not_to be_missing
    end
  else
    it "is missing" do
      expect( validator ).to be_missing
    end
  end
end

describe Lab42::Options::Validator do
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
      it_is_valid false
      it_has_missing( c: true )
      it_has_spurious( {} )

    end # context "required missing"

    context "spurious" do 
      before do
        validator.validate c: 39, d: "Hello", e: "World"
      end
      it_is_valid false
      it_has_missing( {} )
      it_has_spurious( d: "Hello", e: "World"  )
      

    end # context "spurious"

    context "required missing and spurious" do 
      before do
        validator.validate a: 1, f: :lab42
      end
      
      it_is_valid false
      it_has_missing( c: true )
      it_has_spurious( f: :lab42 )

    end # context "required missing and spurious"

  end # context 'spurious'

end # describe Lab42::Options::Validator
