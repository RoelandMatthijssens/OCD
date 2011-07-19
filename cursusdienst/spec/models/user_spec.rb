require 'spec_helper'

describe User do
  before(:each) do
    @permission_group = Factory(:permission_group)
    @attr = {
      :full_name => "User full_name",
      :email => "User email",
      :user_name => "User user_name"
      }
  end
  it "should create a new instance given valid attributes" do
    @permission_group.users.create!(@attr)
  end
  it "should have a full_name" do
    user = User.new(@attr.merge(:full_name => ""))
    user.should_not be_valid
  end
  it "should have an email" do
    user = User.new(@attr.merge(:email => ""))
    user.should_not be_valid
  end
  it "should have a user_name" do
    user = User.new(@attr.merge(:user_name => ""))
    user.should_not be_valid
  end
  it "should have a discipline attribute" do
    user = User.new(@attr)
    user.should respond_to(:discipline)
  end
  it "should have a permission_group attribute" do
    user = User.new(@attr)
    user.should respond_to(:permission_group)
  end
  it "should have a permission_group" do
    user = User.new(@attr.merge(:permission_group => ""))
    user.should_not be_valid
  end
  describe "uniqueness" do
    before(:each) do
      @NOT_attr = {
        :full_name => "NOT User full_name",
        :email => "NOT User email",
         :last_name => "NOT User last_name"
       }
    end
    it "should have a unique user_name" do
      user1 = User.create(@attr)
      user2 = User.new(@NOT_attr.merge(:user_name => "User user_name"))
      user2.should_not be_valid
    end
  end
end
