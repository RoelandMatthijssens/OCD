require 'spec_helper'

describe Message do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  subject { Factory(:message) }
  
  it { should belong_to(:guild) }
  it { should validate_presence_of(:guild) }
  
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
