require 'spec_helper'

describe MaterialOrder do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end

  it { should belong_to(:order) }
  it { should belong_to(:material) }
  it { should belong_to(:guild) }

  it { should validate_presence_of(:guild) }
  it { should validate_presence_of(:material) }
  it { should validate_presence_of(:order) }
  
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
