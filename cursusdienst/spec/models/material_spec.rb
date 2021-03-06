require 'spec_helper'

describe Material do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  subject { Factory(:material) }

  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:typee) }
  it { should validate_presence_of(:printable) }

  it { should belong_to(:subject) }
  it { should belong_to(:parent) }
  it { should have_and_belong_to_many(:options) }
  it { should have_many(:supplies) }
  it { should have_many(:guilds).through(:supplies) }
  it { should have_many(:sales) }
  it { should have_many(:users).through(:sales) }

  it { should have_many(:material_orders) }
  it { should have_many(:orders).through(:material_orders) }
  it { should have_many(:print_job_items) }
  it { should have_many(:print_jobs).through(:print_job_items) }

  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end

# == Schema Information
#
# Table name: materials
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  subject_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#  nr         :integer(4)
#
