require 'spec_helper'

describe Lab42::PermissiveOptions do 
  subject do
    described_class.new
  end

  context 'after parsing' do 
    it 'can be empty' do
      options = subject.parse []
      expect( options.args ).to be_empty
    end
    it 'or not...' do
      options = subject.parse %w{a b c}
      expect( options.args ).to eq %w{a b c}
    end
  end # context 'after parsing'
end # describe Lab42::Options

