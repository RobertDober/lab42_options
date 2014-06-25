require 'spec_helper'

require_relative '../../lib/lab42/options/parameter_group/element'

describe Lab42::Options::ParameterGroup::Element do
  context "implicit form (no defaults)" do 
    subject do
      described_class.new :elem1
    end
    it "has a name" do
      expect( subject.name ).to eq :elem1
    end
    it "has no default" do
      expect( subject ).not_to have_default
    end
  end # context "implicit form (no defaults)"

  context "explicit form" do
    subject do
      described_class.new :elem1, default: 42
    end
    it "has a name" do
      expect( subject.name ).to eq :elem1
    end
    it "has a default" do
      expect( subject ).to have_default
    end
    it "has the correct default" do
      expect( subject.default ).to eq 42
    end
  end
end # describe Lab42::Options::ParameterGroup
