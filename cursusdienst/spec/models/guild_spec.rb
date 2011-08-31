require 'spec_helper'

describe Guild do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  subject { Factory(:guild) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:initials) }
  it { should validate_presence_of(:disciplines) }
  
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:initials) }
  
  it { should have_and_belong_to_many(:users)}
  it { should have_and_belong_to_many(:disciplines) }
  
  it { should have_many(:supplies) }
  it { should have_many(:material_orders) }
  it { should have_many(:messages) }
  it { should have_many(:shopping_cart_items) }
  it { should have_many(:materials).through(:supplies) }
  
  it "should create a new instance given valid attributes" do
    discipline = Factory(:discipline)
    @attr = { :name => 'Infogroep', :initials => 'IG' }
    guild = Guild.new(@attr)
    guild.disciplines << discipline
    guild.should be_valid
  end
  
  it "should have the correct users in ALPHABETICAL order" do
    guild = Factory(:guild)
    u1 = Factory(:user)
    u2 = Factory(:user)
    u3 = Factory(:user)
    u4 = Factory(:user)
    u1.last_name = "bbb"; u2.last_name = "ccc"; u3.last_name = "aaa"; u4.last_name = "aaa"
    u3.name = "bbb"; u4.name = "aaa"
    users = [u1, u2, u3, u4]
    users.each{|x| x.save; guild.users << x}
    
    guild.users.should == [u4, u3, u1, u2]
  end
  it "should have the correct materials in ALPHABETICAL order" do
    guild = Factory(:guild)
    material1 = Factory(:material)
    material2 = Factory(:material)
    material3 = Factory(:material)
    material1.name = "bbb"; material2.name = "ccc"; material3.name = "aaa"
    materials = [material1, material2, material3]
    materials.each{|x| x.save; guild.materials << x}
    
    guild.materials.should == [material3, material1, material2]
  end
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end

# == Schema Information
#
# Table name: associations
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  initials      :string(255)
#  discipline_id :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

