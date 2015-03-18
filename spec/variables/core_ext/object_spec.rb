require File.expand_path('../../../../lib/variables/core_ext/object', __FILE__)

RSpec.describe Variables::CoreExt::Object do
  subject { Object.new }

  describe '#instance_variable' do
    it 'should initialize a new InstanceVariable' do
      variable = Variables::InstanceVariable
      expect(variable).to receive(:new).with(subject, :test).and_return(true)

      value = subject.instance_variable(:test)
      expect(value).to eq(true)
    end
  end

  describe '#instance_variable_fetch' do
    it 'should delegate #fetch to the named instance variable' do
      var = double('instance variable')
      block = proc { }
      expect(subject).to receive(:instance_variable).with(:test).and_return(var)
      expect(var).to receive(:fetch).with(:a, :b, &block).and_return(:example)
      value = subject.instance_variable_fetch(:test, :a, :b, &block)
      expect(value).to eq(:example)
    end
  end

  describe '#instance_variable_replace' do
    it 'should delegate #replace to the named instance variable' do
      var = double('instance variable')
      block = proc { }
      expect(subject).to receive(:instance_variable).with(:test).and_return(var)
      expect(var).to receive(:replace).with(:a, :b, &block).and_return(:example)
      value = subject.instance_variable_replace(:test, :a, :b, &block)
      expect(value).to eq(:example)
    end

    it 'should support a hash of variables to replace' do
      subject.instance_variable_replace(:one => 1, :two => 2) do
        expect(subject.instance_variable_get('@one')).to eq(1)
        expect(subject.instance_variable_get('@two')).to eq(2)
      end

      expect(subject.instance_variable_get('@one')).to be_nil
      expect(subject.instance_variable_get('@two')).to be_nil
    end

    it 'should only support a hash of variables if a block is given' do
      action = proc { subject.instance_variable_replace(:one => 1, :two => 2) }
      expect(action).to raise_error(ArgumentError)
    end
  end
end
