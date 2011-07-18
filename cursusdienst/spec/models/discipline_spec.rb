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
    no_name_discipline = @faculty.disciplines.new(@attr.merge(:name => ""))
    no_name_discipline.should_not be_valid
  end
  it "should require a faculty" do
    no_name_discipline = Discipline.new(@attr.merge(@attr))
    no_name_discipline.should_not be_valid
  end
  
  describe "faculty associations" do
    before (:each) do
      @discipline = @faculty.disciplines.create(@attr)
    end
    it "should have a faculty attribute" do
      @discipline.should respond_to(:faculty)
    end
    it "should have a institute attribute" do
      @discipline.should respond_to(:institute)
    end
    it "should have the right associated faculty" do
      @discipline.faculty_id.should == @faculty.id
      @discipline.faculty.should == @faculty
    end
    it "should have the right associated institute" do
      @discipline.institute.should == @faculty.institute
    end
    describe "uniqueness constraints" do
      before(:each) do
        @not_attr = {:name => "not Computer Wetenschappen"}
      end
      it "should not allow two disciplines with the same name in a single faculty" do
        @d1 = @faculty.disciplines.create(@attr.merge(:name => "something"))
        @d2 = @faculty.disciplines.create(@attr.merge(:name => "something"))
        @d2.should_not be_valid
      end
      it "should not allow two disciplines with the same name in a single school"
#        inst = Factory(:institute)
#        fac1 = inst.faculties.create(:name => 'Wetenschappen')
#        fac2 = inst.faculties.create(:name => 'Geneeskunde')
    end
  end
  
  describe "Subject associations" do
    before (:each) do
      @discipline = @faculty.disciplines.create(@attr)
      @s1 = Factory(:subject, :disciplines => [@discipline])
      @s2 = Factory(:subject, :disciplines => [@discipline])
    end
    it "should have a subject attribute" do
      @discipline.should respond_to(:subjects)
    end
    it "should have the correct subjects in alfabetical order" do
      @discipline.subjects.should == [@s1, @s2]
    end
  end
end
