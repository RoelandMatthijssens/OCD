require 'spec_helper'

#      t.string :full_name
#      t.string :user_name
#      t.column :rolno, :smallint
#      t.string :faculty
#      t.string :subject
#      t.string :email

describe User do
  
  before :each do
    @attr = { :full_name => "Example Name", :rolno => 90133, :user_name => "rivmeche", :email => "name@mydomain.com" }
  end 
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end 
  
  it "should require a user_name" do
    no_name_user = User.new(@attr.merge(:user_name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require a rolno" do
    no_rollno_user = User.new(@attr.merge(:rolno => ""))
    no_rollno_user.should_not be_valid
  end
  
  describe "uniqueness" do
    before :each do
      @other_attr = {
        :full_name => "Not Example Name",
        :rolno => 90133+1,
        :user_name => "Not rivmeche",
        :email => "Notname@mydomain.com"
        }
    end
    it "should allow 2 distinct users" do
      User.create!(@attr)
      second_user = User.new(@other_attr)
      second_user.should be_valid
    end
    it "should have a unique user_name" do
#    TODO:
#      This is in essence not correct, two schools might have someone with the
#      same name but allowing this will prove to be a problem when logging in. 
#      You don't want to give a school name when logging in, and you might not
#      even belong to a school however, when u will not allow 2 usernames to be
#      the same, some schools might not be able to use their equivalent to the 
#      NetID
      User.create!(@attr)
      second_user = User.new(@other_attr.merge(:user_name => "rivmeche"))
      second_user.should_not be_valid
    end
    it "should have a unique" do
      User.create!(@attr)
      second_user = User.new(@other_attr.merge(:user_name => "rivmeche"))
      second_user.should_not be_valid
    end
  end
end
