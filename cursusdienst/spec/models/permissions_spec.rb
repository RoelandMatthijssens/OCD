require 'spec_helper'

describe Permissions do
  before :each do
    @attr = { :name => "root", :level => 0 }
  end 
  
  it "should create a new instance given valid attributes" do
    Permissions.create!(@attr)
  end 

  it "should require a name and level"do
    no_level_permission = Permissions.new(@attr.merge(:name => "", :level => ""))
    no_level_permission.should_not be_valid
  end 
  
end
