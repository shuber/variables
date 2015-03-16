require File.expand_path('../../../../lib/variables/core_ext/module', __FILE__)

RSpec.describe Variables::CoreExt::Module do
  subject { Class.new.send(:include, described_class) }

  it 'todo' do
  end
end
