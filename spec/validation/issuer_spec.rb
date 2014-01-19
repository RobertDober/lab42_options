require 'spec_helper'

describe Lab42::Options::ErrorIssuer, :wip do

  let(:validator){Lab42::Options::Validator.new({})}
  
  context "no strict mode" do 
    let(:options){Lab42::PermissiveOptions.new}

    context 'no missing, no spurious' do 
      before do
        validator.stub(:missing){{}}
        validator.stub(:spurious){{}}
        $stderr.should_not_receive( :puts )
      end
      subject do
        described_class.new(options, validator)
      end
      it 'does not raise an error' do
        expect( ->{ subject.handle_errors! } ).not_to raise_error
      end
      
      
    end # context 'no errors, no spurious'

    context 'missing but no spurious' do 
      
    end # context 'missing but no spurious'

    context 'spurious but no missing' do 
      
    end # context 'spurious but no missing'

    context 'missing and spurious' do 
      
    end # context 'missing and spurious'
  end # context "no strict mode"
  
  context 'strict mode warnings' do 
    let(:options){Lab42::Options.new.strict(:with_warnings)}

    context 'no missing, no spurious' do 
      
    end # context 'no errors, no spurious'

    context 'missing but no spurious' do 
      
    end # context 'missing but no spurious'

    context 'spurious but no missing' do 
      
    end # context 'spurious but no missing'

    context 'missing and spurious' do 
      
    end # context 'missing and spurious'
    
  end # context 'strict mode warnings'

  context 'strict mode errors' do 
    let(:options){Lab42::Options.new.strict(:with_errors)}

    context 'no missing, no spurious' do 
      
    end # context 'no errors, no spurious'

    context 'missing but no spurious' do 
      
    end # context 'missing but no spurious'

    context 'spurious but no missing' do 
      
    end # context 'spurious but no missing'

    context 'missing and spurious' do 
      
    end # context 'missing and spurious'
    
  end # context 'strict mode errors'
  
end # describe Lab42::Options::ErrorIssuer
