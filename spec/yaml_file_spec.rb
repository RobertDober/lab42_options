require 'spec_helper'

shared_examples "with yaml file" do
  it "reads e from the parameters, not from file" do
    expect( subject.e ).to eq("42")
  end
  it "gets values from the file if they are not provided by params (even for defaulted)" do
    expect( subject.b ).to eq( c: "43" )
    expect( subject.kwds[:b]).to eq( c: "43")
  end
end

shared_examples "without yaml file" do
  it "behaves as if read_from had not been called" do
    expect( subject.e ).to eq( "42" )
  end
end

describe Lab42::Options do
  let :yaml_content do
    <<-EOYML
b:
  c: "43"
e: "jello"
    EOYML
  end

  let(:yaml_file){"./.options.yml"}
  let(:other_file){"dummy"}
  let(:options){Lab42::Options.new( a: 43, b: 44).strict( false )}

  context "reading from prefedined yaml file" do
    before do
      stub_read_file yaml_file, with_content: yaml_content
    end
    subject do
      options.read_from yaml_file
      options.parse( *%W{e: 42} )
    end
    
    it_behaves_like "with yaml file"

  end # context "reading from predefined yaml file"

  context "reading from undefined yaml file" do 
    before do
      stub_file_does_not_exist yaml_file
    end
    subject do
      options.read_from yaml_file
      options.parse( *%W{e: 42} )
    end
    it_behaves_like "without yaml file"
  end # context "reading from undefined yaml file"

  context "reading from user provided yaml file" do
    context "user provides the existing file" do 
      before do
        stub_read_file yaml_file, with_content: yaml_content
      end
      subject do
        options.read_from :file
        options.parse( *%W{e: 42 file: #{yaml_file}} )
      end

      it_behaves_like "with yaml file"
    end # context "user provides the file"

    context "user provides a non existing file" do
      before do
        stub_file_does_not_exist yaml_file
      end
      subject do
        options.read_from :file
        options.parse( *%W{e: 42 file: #{yaml_file}} )
      end

      it_behaves_like "without yaml file"
    end

  end # context "reading from user provided yaml file"

  context "reading from default yaml file" do
    context "user overrides with an existing file" do
      before do
        stub_read_file yaml_file, with_content: yaml_content
      end
      subject do
        options.read_from file: other_file
        options.parse( *%W{e: 42 file: #{yaml_file}} )
      end

      it_behaves_like "with yaml file"
    end # context "user provides the file"

    context "user overrides with a non existing file" do
      before do
        stub_file_does_not_exist yaml_file
      end
      subject do
        options.read_from file: other_file
        options.parse( *%W{e: 42 file: #{yaml_file}} )
      end

      it_behaves_like "without yaml file"
    end

    context "using existing default file" do 
      before do
        stub_read_file yaml_file, with_content: yaml_content
      end
      subject do
        options.read_from file: yaml_file
        options.parse( *%W{e: 42} )
      end

      it_behaves_like "with yaml file"
      
    end # context "using default file"
    context "using non existing default file" do 
      before do
        stub_file_does_not_exist yaml_file
      end
      subject do
        options.read_from file: yaml_file
        options.parse( *%W{e: 42} )
      end

      it_behaves_like "without yaml file"
      
    end # context "using default file"

  end # context "reading from user provided yaml file"
end # describe Lab42::Options
