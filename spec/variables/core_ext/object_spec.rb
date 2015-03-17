require File.expand_path('../../../../lib/variables/core_ext/object', __FILE__)

RSpec.describe Variables::CoreExt::Object do
  subject { Object.new.extend(described_class) }

  describe '#instance_variable' do
    it 'should initialize a new InstanceVariable' do
      variable = Variables::InstanceVariable
      expect(variable).to receive(:new).with(subject, :test).and_return(true)

      value = subject.instance_variable(:test)
      expect(value).to eq(true)
    end
  end

  describe '#instance_variable_fetch' do
    it 'should return the value if it is defined' do
      subject.instance_variable_set('@test', :example)
      value = subject.instance_variable_fetch(:test)
      expect(value).to eq(:example)
    end

    it 'should raise UndefinedVariable if the value is not defined' do
      action = proc { subject.instance_variable_fetch(:test) }
      expect(action).to raise_error(Variables::UndefinedVariable)
    end
  end

  describe '#instance_variable_replace' do
    it 'should replace a variable and return the old value' do
      expect(subject.instance_variable_replace(:test, :value)).to be_nil
      expect(subject.instance_variable_get('@test')).to eq(:value)
    end

    it 'should replace a variable for the duration of a block' do
      expect(subject.instance_variable_get('@undefined')).to be_nil

      subject.instance_variable_replace(:undefined, :value) do
        expect(subject.instance_variable_get('@undefined')).to eq(:value)
      end

      expect(subject.instance_variable_get('@undefined')).to be_nil
    end

    it 'should return the last expression of a block' do
      value = subject.instance_variable_replace(:test, :value) { :example }
      expect(value).to eq(:example)
    end
  end
end
