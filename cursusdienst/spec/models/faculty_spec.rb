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
  
  it "should destroy associated disciplines" do
    @faculty.destroy
    [@d1, @d2].each do |discipline|
      Discipline.find_by_id(discipline.id).should be_nil
    end
  
#  before :each do
#    @institute = Factory(:institute)
#    @attr = {
#      :name => "Wetenschappen",
#      :initials => "WE"
#      }
#  end
#  
#  it "should create a new instance given valid attributes" do
#    @institute.faculties.create!(@attr)
#  end
#    describe "uniquness constraints" do
#      before(:each) do
#        @notattr = {
#          :name => "NotWetenschappen",
#          :initials => "NWE"
#        }
#      end
#      it "should not allow two faculties with the same name in a single institute" do
#        @another_faculty = @institute.faculties.create(@notattr.merge(:name => "Wetenschappen"))
#        @another_faculty.should_not be_valid
#      end
#      it "should not allow two faculties with the same initials in a single institute" do
#        @another_faculty = @institute.faculties.create(@notattr.merge(:initials => "WE"))
#        @another_faculty.should_not be_valid
#      end
#    end
#  end
#  
#  describe "discipline associations" do
#    before (:each) do
#      @faculty = @institute.faculties.create(@attr)
#      @d1 = Factory(:discipline, :faculty => @faculty)
#      @d2 = Factory(:discipline, :faculty => @faculty)
#    end
#    it "should have the right disciplines in alfabetical order" do
#      @faculty.disciplines.should == [@d1, @d2]
#    end
#    it "should destroy associated disciplines" do
#      @faculty.destroy
#      [@d1, @d2].each do |discipline|
#        Discipline.find_by_id(discipline.id).should be_nil
#      end
#    end
#  end
end
