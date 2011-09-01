require 'spec_helper'

describe PrintJobItem do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  
  it { should belong_to :print_job }
  it { should belong_to :material }
  
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
