require 'spec_helper'

describe Lab42::Options do

  context "simple use case" do

    subject do
      Lab42::PermissiveOptions.new.parse(*%W{hello world :verbose answer: 42})
    end

    it 'yields original params' do
      expect( subject.to_a ).to eq(%W{hello world :verbose answer: 42})
    end

    it 'yields the positional params' do
      expect( subject.args ).to eq(%W{hello world})
    end

    it 'yields the kwd params' do
      expect( subject.kwds[:answer] ).to eq("42")
      expect( subject.kwds.answer ).to eq("42")
    end

  end

  context "kwd forwarding to options result (no need to write .kwds)" do
    subject do
      Lab42::PermissiveOptions.new.parse(*%W{hello :verbose kwds: yes world answer: 42})
    end
    it 'yields the positional params' do
      expect( subject.args ).to eq(%W{hello world})
    end
    it 'one can access answer directly' do
      expect( subject[:answer] ).to eq("42")
      expect( subject.answer ).to eq("42")
    end
    it 'but not kwds' do
      expect( subject.kwds.kwds ).to eq("yes")
    end
  end
  
end
