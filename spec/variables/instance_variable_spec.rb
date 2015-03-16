require File.expand_path('../../../lib/variables/instance_variable', __FILE__)

RSpec.describe Variables::InstanceVariable do
  subject { described_class.new(owner, name) }

  let(:owner) { Object.new }
  let(:name)   { :undefined }

  describe '#defined?' do
    it 'should return false if the variable is undefined' do
      expect(subject).not_to be_defined
    end

    it 'should return true if the variable is defined' do
      owner.instance_variable_set('@undefined', nil)
      expect(subject).to be_defined
    end
  end

  describe '#fetch' do
    it 'should raise UndefinedVariable if the variable is undefined' do
      action = proc { subject.fetch }
      expect(action).to raise_error(Variables::UndefinedVariable)
    end

    it 'should return the value if the variable is defined' do
      owner.instance_variable_set('@undefined', :value)
      expect(subject.fetch).to eq(:value)
    end

    it 'should return the default value if the variable is undefined' do
      expect(subject.fetch(:value)).to eq(:value)
    end

    it 'should return the block result if the variable is undefined' do
      value = subject.fetch { |name| name }
      expect(value).to eq('@undefined')

      value = subject.fetch { :value }
      expect(value).to eq(:value)
    end
  end

  describe '#get' do
    it 'should return nil if the variable is undefined' do
      expect(subject.get).to be_nil
    end

    it 'should return the value if the variable is defined' do
      owner.instance_variable_set('@undefined', :value)
      expect(subject.get).to eq(:value)
    end
  end

  describe '#owner' do
    it 'should return the original owner' do
      expect(subject.owner).to eq(owner)
    end
  end

  describe '#replace' do
    it 'should replace a variable and return the old value' do
      expect(subject.replace(:value)).to be_nil
      expect(owner.instance_variable_get('@undefined')).to eq(:value)
    end

    it 'should replace a variable for the duration of a block' do
      expect(owner.instance_variable_get('@undefined')).to be_nil

      subject.replace(:value) do
        expect(owner.instance_variable_get('@undefined')).to eq(:value)
      end

      expect(owner.instance_variable_get('@undefined')).to be_nil
    end

    it 'should return the last expression of a block' do
      value = subject.replace(:value) { :test }
      expect(value).to eq(:test)
    end
  end

  describe '#set' do
    it 'should set the new value if the variable is undefined' do
      subject.set(:value)
      value = owner.instance_variable_get('@undefined')
      expect(value).to eq(:value)
    end

    it 'should overwrite a value if the variable is defined' do
      owner.instance_variable_set('@undefined', nil)
      subject.set(:value)
      value = owner.instance_variable_get('@undefined')
      expect(value).to eq(:value)
    end
  end
end
