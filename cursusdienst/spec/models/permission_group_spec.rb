require 'spec_helper'

describe PermissionGroup do
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
    u1.full_name = "bbb"; u2.full_name = "ccc"; u3.full_name = "aaa"
    users = [u1, u2, u3]
    users.each{|x| permission_group.users << x}
    permission_group.users.should == [u3, u1, u2]
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

