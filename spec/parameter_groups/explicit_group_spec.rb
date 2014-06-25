require 'spec_helper'

describe Lab42::Options do 
  context "explicit group" do 
    subject do
      described_class
        .new
        .group :substitution do | g |
          g.element :sub
          g.element :with, default: ""
        end
    end

    it 'can be parsed with missing with keywords' do
      expect( subject.parse( %w{sub: a, sub: c, with: d} ).groups.substitution ).to eq [{sub: "a", with: ""}, {sub: "c", with: "d"}]
    end
  end # context "explicit group"
end # describe Lab42::Option
