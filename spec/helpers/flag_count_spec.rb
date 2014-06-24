require 'spec_helper'

describe Lab42::Options do 
  subject do
    described_class.new a: [], b: [], c: nil, d: nil
  end

  context 'keywords as mutliple flags' do 
    let(:options){ subject.parse %w{ :a a: 2 :a b: 3 :c d: hello} }


    it 'counts :a as flags' do
      expect( options.a.flag_count ).to eq 2
    end

    it 'does not count :b as flags' do
      expect( options.b.flag_count ).to be_zero
    end

    it 'counts :c as flags' do
      expect( options.c.flag_count ).to eq 1
    end

    it 'does not count :d as flags' do
      expect( options.d.flag_count ).to be_zero
    end

  end # context 'keywords as mutliple flags'
end # describe Lab42::Options
