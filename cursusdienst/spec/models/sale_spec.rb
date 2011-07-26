require 'spec_helper'

describe Sale do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  subject { Factory(:sale) }
  
  it { should belong_to(:guild) }
  it { should belong_to(:material) }
  
  it "should create a relation starting from guild" do
    guild = Factory(:guild)
    material = Factory(:material)
    lambda do
      guild.materials << material
    end.should change(Sale, :count).by(1)
  end
  it "should create a relation starting from material" do
    guild = Factory(:guild)
    material = Factory(:material)
    lambda do
      material.guilds << guild
    end.should change(Sale, :count).by(1)
  end
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end
