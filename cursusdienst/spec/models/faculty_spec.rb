require 'spec_helper'

describe Faculty do
  before :each do
    @institute = Factory(:institute)
    @attr = {
      :name => "Wetenschappen",
      :initials => "WE"
      }
  end
  
  it "should create a new instance given valid attributes" do
    @institute.faculties.create!(@attr)
  end
  it "should require a name" do
    no_name_faculty = Faculty.new(@attr.merge(:name => ""))
    no_name_faculty.should_not be_valid
  end
  it "should require initials" do
    no_initials_faculty = Faculty.new(@attr.merge(:initials => ""))
    no_initials_faculty.should_not be_valid
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
  
  describe "uniquness constraints" do
    before(:each) do
      @notattr = {
        :name => "NotWetenschappen",
        :initials => "NWE"
      }
    end
    it "should not allow two faculties with the same name in a single institute" do
      @faculty1 = @institute.faculties.create(@attr)
      @faculty2 = @institute.faculties.create(@notattr.merge(:name => "Wetenschappen"))
      @faculty2.should_not be_valid
    end
    it "should not allow two faculties with the same initials in a single institute" do
      @faculty1 = @institute.faculties.create(@attr)
      @faculty2 = @institute.faculties.create(@notattr.merge(:initials => "WE"))
      @faculty2.should_not be_valid
    end
  end
end
