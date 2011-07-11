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
end
