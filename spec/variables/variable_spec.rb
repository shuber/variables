require File.expand_path('../../../lib/variables/variable', __FILE__)

RSpec.describe Variables::Variable do
  subject { described_class }

  it { is_expected.to be_an(AbstractClass) }
end
