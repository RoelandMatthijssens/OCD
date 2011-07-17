require 'spec_helper'

#      t.string :name
#      t.string :initials
#      t.string :location

describe Institute do
  before :each do
    @attr = {
      :name => "Vrije Universiteit Brussel",
      :initials => "VUB",
      :location => "Elsene Pleinlaan 2"
      }
  end

  it "should create a new instance given valid arguments" do
    Institute.create!(@attr)
  end
  
  it "should not allow an empty name" do
    no_name_institute = Institute.new(@attr.merge(:name => ""))
    no_name_institute.should_not be_valid
  end
  it "should not allow empty initials" do
    no_initials_institute = Institute.new(@attr.merge(:initials => ""))
    no_initials_institute.should_not be_valid
  end
  it "should not allow an empty location" do
    no_location_institute = Institute.new(@attr.merge(:location => ""))
    no_location_institute.should_not be_valid
  end

  describe "uniqueness" do
    before :each do
      @other_attr = {
        :name => "Not Vrije Universiteit Brussel",
        :initials => "Not VUB",
        :location => "Not Elsene Pleinlaan 2"
        }
    end
    it "should allow 2 distinct institutes" do
      second_institute = Institute.new(@other_attr)
      second_institute.should be_valid
    end
    it "should have a unique name" do
      Institute.create!(@attr)
      second_institute = Institute.new(@other_attr.merge(:name => "Vrije Universiteit Brussel"))
      second_institute.should_not be_valid
    end
    
    it "should have unique initials" do
      Institute.create!(@attr)
      second_institute = Institute.new(@other_attr.merge(:initials => "VUB"))
      second_institute.should_not be_valid
    end
  end
  
  describe "faculty associations" do
    before(:each) do
      @institute = Institute.create(@attr)
      @f1 = Factory(:faculty, :institute => @institute)#, :name => "Wetenschappen", :initials => "WE")
      @f2 = Factory(:faculty, :institute => @institute)#, :name => "Letteren en Wijsbegeerte", :initials => "LEW")
    end
    it "should have a faculties attribute" do
      @institute.should respond_to(:faculties)
    end
    it "should have a disciplines attribute" do
      @institute.should respond_to(:disciplines)
    end
    it "should have the right faculties in alfabetical order" do
      @institute.faculties.should == [@f1, @f2]
    end
    it "should only contain the right faculties" do
      @not_institute = Institute.create(@attr.merge(:name => "not Wetenschappen", :initials => "NWE"))
      @f3 = Factory(:faculty, :institute => @not_institute)
      @institute.faculties.should_not include(@f3)
    end
    it "should destroy associated faculties" do
      @institute.destroy
      [@f1, @f2].each do |faculty|
        Faculty.find_by_id(faculty.id).should be_nil
      end
    end
  end
end
