require 'spec_helper'

describe MaterialOrder do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end

  it { should belong_to(:order) }
  it { should belong_to(:material) }
  
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
