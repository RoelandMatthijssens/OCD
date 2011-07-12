require 'spec_helper'

describe Discipline do
  before :each do
    @faculty = Factory(:faculty)
    @attr = {
      :name => "Computer Wetenschappen"
      }
  end
  
  it "should create a new instance given valid attributes" do
    @faculty.disciplines.create!(@attr)
  end
  it "should require a name" do
    no_name_discipline = Discipline.new(@attr.merge(:name => ""))
    no_name_discipline.should_not be_valid
  end
  
  describe "faculty associations" do
    before (:each) do
      @discipline = @faculty.disciplines.create(@attr)
    end
    it "should have a faculty attribute" do
      @discipline.should respond_to(:faculty)
    end
    it "should have the right associated faculty" do
      @discipline.faculty_id.should == @faculty.id
      @discipline.faculty.should == @faculty
    end
  end
end
