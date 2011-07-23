require 'spec_helper'

describe MaterialOption do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  subject { Factory(:material_option) }
  
  it { should validate_presence_of(:key) }
  it { should validate_presence_of(:value) }
  it { should validate_presence_of(:material) }
  
  it { should belong_to(:material) }
  
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
