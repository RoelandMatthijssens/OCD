require 'spec_helper'

describe Faculty do
  before :each do
    @attr = {
      :name => "Computer Wetenschappen"
      }
  end
  
  it "should create a new instance given valid attributes" do
    Faculty.create!(@attr)
  end
  
  it "should require a name" do
    no_name_faculty = Faculty.new(@attr.merge(:name => ""))
    no_name_faculty.should_not be_valid
  end
end
