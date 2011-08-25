require 'spec_helper'

describe ShoppingCartItem do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  
	it { should belong_to :user }
	it { should belong_to :material }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:material) }
  it { should validate_presence_of(:amount) }

  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
