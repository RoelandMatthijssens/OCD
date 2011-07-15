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
    describe "uniquness constraints" do
      before(:each) do
        @notattr = {
          :name => "NotWetenschappen",
          :initials => "NWE"
        }
      end
      it "should not allow two faculties with the same name in a single institute" do
        @another_faculty = @institute.faculties.create(@notattr.merge(:name => "Wetenschappen"))
        @another_faculty.should_not be_valid
      end
      it "should not allow two faculties with the same initials in a single institute" do
        @another_faculty = @institute.faculties.create(@notattr.merge(:initials => "WE"))
        @another_faculty.should_not be_valid
      end
    end
  end
  
  describe "discipline associations" do
    before (:each) do
      @faculty = @institute.faculties.create(@attr)
      @d1 = Factory(:discipline, :faculty => @faculty, :name => "Computer Wetenschappen")
      @d2 = Factory(:discipline, :faculty => @faculty, :name => "Bio-ingenieurswetenschappen")
    end
    it "should have a disciplines attribute" do
      @faculty.should respond_to(:disciplines)
    end
    it "should have the right disciplines in alfabetical order" do
      @faculty.disciplines.should == [@d2, @d1]
    end
    it "should only contain the right disciplines" do
      @not_faculty = Faculty.create(@attr.merge(:name => "not Computer Wetenschappen"))
      @d3 = Factory(:discipline, :faculty => @not_faculty)
      @faculty.disciplines.should_not include(@d3)
    end
    it "should destroy associated disciplines" do
      @faculty.destroy
      [@d1, @d2].each do |discipline|
        Discipline.find_by_id(discipline.id).should be_nil
      end
    end
  end
end
