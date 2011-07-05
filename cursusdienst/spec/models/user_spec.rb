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
  
  it "should require a user_name and rolno"do
    no_name_user = User.new(@attr.merge(:user_name => "", :rolno => ""))
    no_name_user.should_not be_valid
  end 
  
end
