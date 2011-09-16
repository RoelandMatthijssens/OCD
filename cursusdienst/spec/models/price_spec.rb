require 'spec_helper'

describe Price do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  it { should belong_to(:price_set) }
  it { should belong_to(:extra_option) }

  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
