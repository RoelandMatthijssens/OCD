require 'spec_helper'

describe Faculty do
  before :each do
    @institute = Factory(:institute)
    @attr = {
      :name => "Computer Wetenschappen"
      }
  end
  
  it "should create a new instance given valid attributes" do
    @institute.faculties.create!(@attr)
  end
  it "should require a name" do
    no_name_faculty = Faculty.new(@attr.merge(:name => ""))
    no_name_faculty.should_not be_valid
  end
  
  describe "institute associations" do
    before (:each) do
      @faculty = @institute.faculties.create(@attr)
    end
    it "should have a institute attribute" do
      @faculty.should respond_to(:institute)
    end
    it "should have the right associated institute" do
      @faculty.institute_id.should == @institute.id
      @faculty.institute.should == @institute
    end
  end
end
