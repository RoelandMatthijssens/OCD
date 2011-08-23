require 'spec_helper'

describe Order do

  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  
  it { should belong_to (:user) }
  it { should belong_to (:guild) }
  it { should have_and_belong_to_many (:materials) }
  
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
