require 'spec_helper'

describe Lab42::Options do

  context "simple use case" do

    subject do
      Lab42::PermissiveOptions.new.parse(*%W{hello world :verbose answer: 42})
    end

    it 'yields original params' do
      subject.to_a.should eq(%W{hello world :verbose answer: 42})
    end

    it 'yields the positional params' do
      subject.args.should eq(%W{hello world})
    end

    it 'yields the kwd params' do
      subject.kwds[:answer].should eq("42")
      subject.kwds.answer.should eq("42")
    end

  end

  context "kwd forwarding to options result (no need to write .kwds)" do
    subject do
      Lab42::PermissiveOptions.new.parse(*%W{hello :verbose kwds: yes world answer: 42})
    end
    it 'yields the positional params' do
      subject.args.should eq(%W{hello world})
    end
    it 'one can access answer directly' do
      subject[:answer].should eq("42")
      subject.answer.should eq("42")
    end
    it 'but not kwds' do
      subject.kwds.should_not eq("yes")
      subject.kwds.kwds.should eq("yes")
    end
  end
  
end
