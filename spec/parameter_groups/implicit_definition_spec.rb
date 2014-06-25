require 'spec_helper'

describe Lab42::Options do 
  subject do
    described_class.new sub: :substitution, with: :substitution
  end

  context "empty" do 
    it 'is allowed' do
      expect( subject.parse( [] ).groups.substitution ).to be_empty
    end
  end # context "empty"
end # describe Options
