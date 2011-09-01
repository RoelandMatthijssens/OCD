require 'spec_helper'

describe PrintJob do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  
	it { should have_many(:print_job_items) }
	it { should have_many(:materials).through(:print_job_items) }
	
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
