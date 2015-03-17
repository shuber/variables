require File.expand_path('../../../../lib/variables/core_ext/module', __FILE__)

RSpec.describe Variables::CoreExt::Module do
  subject { Class.new.extend(described_class) }

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
  end
end
