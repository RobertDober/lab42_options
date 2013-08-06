require 'spec_helper'

describe Lab42::Options do

  context "simple use case", :wip do

    subject do
      options = Lab42::Options.new
      options.parse( *%W{key: val1 :key :other answer: 42 key: val2} )
    end

    it 'yields original params' do
      subject.to_a.should eq(%W{key: val1 :key :other answer: 42 key: val2})
    end

    it 'yields the positional params' do
      subject.args.should be_empty
    end

    it 'yields the kwd params' do
      subject.kwds[:answer].should eq("42")
      subject.kwds.other.should eq(true)
      subject.key.should eq(["val1", true, "val2"])
    end

  end

end
