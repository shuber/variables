require File.expand_path('../../../lib/variables/interface', __FILE__)

RSpec.describe Variables::Interface do
  subject { Class.new.send(:include, described_class).new }

  it 'should raise NotImplementedError for all methods' do
    described_class.instance_methods(false).each do |method|
      action = subject.method(method).to_proc
      expect(action).to raise_error(NotImplementedError)
    end
  end
end
