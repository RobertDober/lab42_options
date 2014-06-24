require 'spec_helper'

describe Lab42::Options do

  context "simple use case" do

    subject do
      options = Lab42::PermissiveOptions.new
      options.parse( *%W{key: val1 :key :other answer: 42 key: val2} )
    end

    it 'yields original params' do
      expect( subject.to_a ).to eq(%W{key: val1 :key :other answer: 42 key: val2})
    end

    it 'yields the positional params' do
      expect( subject.args ).to be_empty
    end

    it 'yields the kwd params' do
      expect( subject.kwds[:answer] ).to eq("42")
      expect( subject.kwds.other ).to eq(true)
      expect( subject.key ).to eq(["val1", true, "val2"])
    end

  end

end
