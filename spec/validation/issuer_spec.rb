require 'spec_helper'

describe Lab42::Options::ErrorIssuer do

  let(:validator){Lab42::Options::Validator.new({})}
  subject do
    described_class.new(options, validator)
  end

  context "no strict mode" do 
    let(:options){Lab42::PermissiveOptions.new}

    context 'no missing, no spurious' do 
      before do
        validator.stub(:missing){{}}
        validator.stub(:spurious){{}}
        $stderr.should_not_receive( :puts )
      end
      it 'does not raise an error' do
        expect( ->{ subject.handle_errors! } ).not_to raise_error
      end
    end # context 'no errors, no spurious'

    context 'missing but no spurious' do 
      before do
        validator.stub(:missing){{a: true, b: true}}
        validator.stub(:spurious){{}}
        $stderr.should_not_receive( :puts )
      end
      it 'raises an error' do
        expect( ->{ subject.handle_errors! } ).to raise_error( /missing required parameters: :a, :b/ )
      end
    end # context 'missing but no spurious'

    context 'spurious but no missing' do 
      before do
        validator.stub(:missing){{}}
        validator.stub(:spurious){{a: 43, b: 44}}
        $stderr.should_not_receive( :puts )
      end
      it 'does not raise an error' do
        expect( ->{ subject.handle_errors! } ).not_to raise_error
      end
    end # context 'spurious but no missing'

    context 'missing and spurious' do 
      before do
        validator.stub(:missing){{a: true, b: true}}
        validator.stub(:spurious){{c: 42, d: 44}}
        $stderr.should_not_receive( :puts )
      end
      it 'raises an error' do
        expect( ->{ subject.handle_errors! } ).to raise_error( /missing required parameters: :a, :b/ )
      end

    end # context 'missing and spurious'
  end # context "no strict mode"

  context 'strict mode warnings' do 
    let(:options){Lab42::Options.new.strict(:with_warnings)}

    context 'no missing, no spurious' do 
      before do
        validator.stub(:missing){{}}
        validator.stub(:spurious){{}}
        $stderr.should_not_receive( :puts )
      end
      it 'does not raise an error' do
        expect( ->{ subject.handle_errors! } ).not_to raise_error
      end
    end # context 'no errors, no spurious'

    context 'missing but no spurious' do 
      before do
        validator.stub(:missing){{a: true, b: true}}
        validator.stub(:spurious){{}}
        $stderr.should_not_receive( :puts )
      end
      it 'raises an error' do
        expect( ->{ subject.handle_errors! } ).to raise_error( /missing required parameters: :a, :b/ )
      end

    end # context 'missing but no spurious'

    context 'spurious but no missing' do 
      before do
        validator.stub(:missing){{}}
        validator.stub(:spurious){{a: 43, b: 44}}
        $stderr.should_receive( :puts ).with( /unspecified parameter passed: a: 43/ )
        $stderr.should_receive( :puts ).with( /unspecified parameter passed: b: 44/ )
      end
      it 'does not raise an error' do
        expect( ->{ subject.handle_errors! } ).not_to raise_error
      end

    end # context 'spurious but no missing'

    context 'missing and spurious' do 
      before do
        validator.stub(:missing){{c: true, d: true}}
        validator.stub(:spurious){{a: 43, b: 44}}
        $stderr.should_receive( :puts ).with( /unspecified parameter passed: a: 43/ )
        $stderr.should_receive( :puts ).with( /unspecified parameter passed: b: 44/ )
      end
      it 'raises an error' do
        expect( ->{ subject.handle_errors! } ).to raise_error( /missing required parameters: :c, :d/ )
      end

    end # context 'missing and spurious'

  end # context 'strict mode warnings'

  context 'strict mode errors' do 
    let(:options){Lab42::Options.new.strict(:with_errors)}

    context 'no missing, no spurious' do 
      before do
        validator.stub(:missing){{}}
        validator.stub(:spurious){{}}
        $stderr.should_not_receive( :puts )
      end
      it 'does not raise an error' do
        expect( ->{ subject.handle_errors! } ).not_to raise_error
      end

    end # context 'no errors, no spurious'

    context 'missing but no spurious' do 
      before do
        validator.stub(:missing){{a: true, b: true}}
        validator.stub(:spurious){{}}
        $stderr.should_not_receive( :puts )
      end
      it 'raises an error' do
        expect( ->{ subject.handle_errors! } ).to raise_error( /missing required parameters: :a, :b/ )
      end
    end # context 'missing but no spurious'

    context 'spurious but no missing' do 
      before do
        validator.stub(:missing){{}}
        validator.stub(:spurious){{a: 43, b: 44}}
        $stderr.should_not_receive( :puts )
      end
      it 'raises an error' do
        expect( ->{ subject.handle_errors! } ).to raise_error( /unspecified parameters: :a, :b/ )
      end
    end # context 'spurious but no missing'

    context 'missing and spurious' do 
      before do
        validator.stub(:missing){{c: true, d: true}}
        validator.stub(:spurious){{a: 43, b: 44}}
        $stderr.should_not_receive( :puts )
      end
      it 'raises an error' do
        expect( ->{ subject.handle_errors! } ).to raise_error( /unspecified parameters: :a, :b\nmissing required parameters: :c, :d/ )
      end

    end # context 'missing and spurious'

  end # context 'strict mode errors'

end # describe Lab42::Options::ErrorIssuer
