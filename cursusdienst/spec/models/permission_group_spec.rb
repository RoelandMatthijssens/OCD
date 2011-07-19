require 'spec_helper'

describe PermissionGroup do
  before(:each) do
    @attr = {
      :name => "permission_group_name",
      :level => 1
    }
  end
  
  it "should create a new instance given valid attributes" do
    PermissionGroup.create!(@attr)
  end
  it "should have a name" do
    permission_group = PermissionGroup.new(@attr.merge(:name => ""))
    permission_group.should_not be_valid
  end
  it "should have a level" do
    permission_group = PermissionGroup.new(@attr.merge(:level => ""))
    permission_group.should_not be_valid
  end
  it "should have a users attribute" do
    permission_group = PermissionGroup.new(@attr.merge(:level => ""))
    permission_group.should respond_to(:users)
  end
  it "should have the correct users in alphabetical order" do
    permission_group = PermissionGroup.create!(@attr)
    u1 = Factory(:user, :permission_group => permission_group)
    u2 = Factory(:user, :permission_group => permission_group)
    permission_group.users.should == [u1, u2]
  end
  describe "uniqueness" do
    before(:each) do
     @NOT_attr = {
      :name => "NOT_permission_group_name",
      :level => 0
      }
    end
    it "should have a unique name" do
      permission_group1 = PermissionGroup.create(@attr)
      permission_group2 = PermissionGroup.create(@NOT_attr.merge(:name => "permission_group_name"))
      permission_group2.should_not be_valid
    end
    it "should have a unique level" do
      permission_group1 = PermissionGroup.create(@attr)
      permission_group2 = PermissionGroup.create(@NOT_attr.merge(:level => 1))
      permission_group2.should_not be_valid
    end
  end
end
