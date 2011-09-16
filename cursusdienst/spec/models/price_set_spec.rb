require 'spec_helper'

describe PriceSet do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  it { should belong_to(:printer) }
  it { should have_many(:prices) }

  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
