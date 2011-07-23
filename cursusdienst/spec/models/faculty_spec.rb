require 'spec_helper'

describe Faculty do
  subject { Factory(:faculty) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:initials) }
  it { should validate_presence_of(:institute) }
  
  it { should have_many(:disciplines) }
  
  it { should belong_to(:institute) }
  
  it "should have a full_name" do
    Factory(:faculty).should respond_to(:full_name)
  end
  
  it "should create a new instance given valid attributes" do
    institute = Factory(:institute)
    @attr = { :name => "Wetenschappen", :initials => "WE" }
    faculty = Faculty.new(@attr)
    faculty.institute = institute
    faculty.should be_valid
  end
  
  it "should have the correct disciplines in ALPHABETICAL order" do
    faculty = Factory(:faculty)
    discipline1 = Factory(:discipline)
    discipline2 = Factory(:discipline)
    discipline3 = Factory(:discipline)
    discipline1.name = "bbb"; discipline2.name = "ccc"; discipline3.name = "aaa"
    disciplines = [discipline1, discipline2, discipline3]
    disciplines.each{|x| x.save; faculty.disciplines << x}
    
    faculty.disciplines.should == [discipline3, discipline1, discipline2]
  end
  
  it "should destroy associated disciplines" do
    faculty = Factory(:faculty)
    d1 = Factory(:discipline, :faculty => faculty)
    d2 = Factory(:discipline, :faculty => faculty)
    faculty.destroy
    [d1, d2].each do |discipline|
      Discipline.find_by_id(discipline.id).should be_nil
    end
  end
  
  describe "uniqueness" do
    before(:each) do
      @institute = Factory(:institute)
      @attr = { :name => "name", :initials => "initials" }
      @not_attr = { :name => "NOTname", :initials => "NOTinitials" }
      @faculty1 = @institute.faculties.create(@attr)
    end
    it "should not allow two faculties with the same name in a single institute" do
      faculty2 = @institute.faculties.create(@not_attr.merge(:name => "name"))
      faculty2.should_not be_valid
    end
    it "should not allow two faculties with the same initials in a single institute" do
      faculty2 = @institute.faculties.create(@not_attr.merge(:initials => "initials"))
      faculty2.should_not be_valid
    end
  end
end

# == Schema Information
#
# Table name: faculties
#
#  id           :integer(4)      not null, primary key
#  name         :string(255)
#  institute_id :integer(4)
#  created_at   :datetime
#  updated_at   :datetime
#  initials     :string(255)
#

