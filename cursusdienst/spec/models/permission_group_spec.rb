require 'spec_helper'

describe PermissionGroup do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  subject { Factory(:permission_group) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:level) }
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:level) }
  
  it { should have_many(:users) }

  it "should create a new instance given valid attributes" do
    @attr = { :name => "permission_group_name", :level => 1 }
    permission_group = PermissionGroup.new(@attr)
    permission_group.should be_valid
  end
  it "should have the correct users in ALPHABETICAL order" do
    permission_group = Factory(:permission_group)
    u1 = Factory(:user)
    u2 = Factory(:user)
    u3 = Factory(:user)
    u4 = Factory(:user)
    u1.last_name = "bbb"; u2.last_name = "ccc"; u3.last_name = "aaa"; u4.last_name = "aaa"
    u3.name = "bbb"; u4.name = "aaa"
    users = [u1, u2, u3, u4]
    users.each{|x| permission_group.users << x}
    permission_group.users.should == [u4, u3, u1, u2]
  end
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end

# == Schema Information
#
# Table name: permission_groups
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  level      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

