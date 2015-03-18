require File.expand_path('../../../../lib/variables/core_ext/module', __FILE__)

RSpec.describe Variables::CoreExt::Module do
  subject { Class.new }

  describe '#instance_variable' do
    it 'should initialize a new ClassVariable' do
      variable = Variables::ClassVariable
      expect(variable).to receive(:new).with(subject, :test).and_return(true)

      value = subject.class_variable(:test)
      expect(value).to eq(true)
    end
  end

  describe '#class_variable_fetch' do
    it 'should delegate #fetch to the named class variable' do
      var = double('class variable')
      block = proc { }
      expect(subject).to receive(:class_variable).with(:test).and_return(var)
      expect(var).to receive(:fetch).with(:a, :b, &block).and_return(:example)
      value = subject.class_variable_fetch(:test, :a, :b, &block)
      expect(value).to eq(:example)
    end
  end

  describe '#class_variable_replace' do
    it 'should delegate #replace to the named class variable' do
      var = double('class variable')
      block = proc { }
      expect(subject).to receive(:class_variable).with(:test).and_return(var)
      expect(var).to receive(:replace).with(:a, :b, &block).and_return(:example)
      value = subject.class_variable_replace(:test, :a, :b, &block)
      expect(value).to eq(:example)
    end

    it 'should support a hash of variables to replace' do
      subject.class_variable_replace(:one => 1, :two => 2) do
        expect(subject.send(:class_variable_get, '@@one')).to eq(1)
        expect(subject.send(:class_variable_get, '@@two')).to eq(2)
      end

      expect(subject.send(:class_variable_get, '@@one')).to be_nil
      expect(subject.send(:class_variable_get, '@@two')).to be_nil
    end

    it 'should only support a hash of variables if a block is given' do
      action = proc { subject.class_variable_replace(:one => 1, :two => 2) }
      expect(action).to raise_error(ArgumentError)
    end
  end
end
