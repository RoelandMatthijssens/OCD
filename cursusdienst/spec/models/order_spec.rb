require 'spec_helper'

describe Order do

  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  
  it { should belong_to (:user) }
  it { should belong_to (:institute) }

  
	it { should have_many(:material_orders) }
  it { should have_many(:materials).through(:material_orders) }

  it { should validate_presence_of(:payment_type) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:institute) }
  
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
