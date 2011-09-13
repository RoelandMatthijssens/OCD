require 'spec_helper'

describe InfoString do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  it { should validate_presence_of(:key) }
  it { should validate_presence_of(:content) }
  it { should validate_presence_of(:guild) }
  
  it { should belong_to(:guild) }
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
