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
  end

  describe '#instance_variable_replace' do
  end
end
