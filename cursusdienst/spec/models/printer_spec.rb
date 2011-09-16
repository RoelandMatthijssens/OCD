require 'spec_helper'

describe Printer do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  it { should have_many(:price_sets) }

  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
