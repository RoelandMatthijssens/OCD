require 'spec_helper'

describe ActionLog  do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end

  it { should belong_to(:user) }
  it { should validate_presence_of(:action) }
  it { should validate_presence_of(:user) }

  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end

