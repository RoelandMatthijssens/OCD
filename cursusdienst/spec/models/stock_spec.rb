require 'spec_helper'

describe Stock do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  
	it { should belong_to :guild }
	it { should belong_to :material }
	
  it { should validate_presence_of(:amount) }
  it { should validate_presence_of(:typee) }
  
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
