require 'spec_helper'

describe ExtraOption do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  subject { Factory(:extra_option) }

  it { should validate_presence_of(:name) }
  it { should have_and_belong_to_many(:materials) }
  it { should have_many(:prices) }

  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
