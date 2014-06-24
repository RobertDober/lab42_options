require 'spec_helper'

describe Lab42::Options do 
  subject do
    described_class.new a: [], b: nil, c: nil
  end

  context 'keywords as mutliple values' do 
    let(:options){ subject.parse %w{ :a a: 2 :a a: 2 :a a: hello c: hello } }


    it 'counts per values' do
      expect( options.a.counts ).to eq({ true => 3, "hello" => 1, "2" => 2 })
    end

    it 'even if there is only one' do
      expect( options.c.counts ).to eq( "hello" => 1 )
    end

  end # context 'keywords as mutliple flags'
end # describe Lab42::Options
