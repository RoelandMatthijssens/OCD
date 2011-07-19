require 'spec_helper'

describe Association do
  before(:each) do
    @discipline = Factory(:discipline)
    @attr = {:name => "Infogroep", :initials => "IG"}
  end
  it "should create a new instance given valid attributes" do
    @discipline.associations.create!(@attr)
  end
  it "should have a name" do
    no_name_association = @discipline.associations.new(@attr.merge(:name => ""))
    no_name_association.should_not be_valid
  end
  it "should have initials" do
    no_initials_association = @discipline.associations.new(@attr.merge(:initials => ""))
    no_initials_association.should_not be_valid
  end
  
  describe "uniqueness" do
    before(:each) do
      @not_attr = {:name => "NOT_Infogroep", :initials => "NOT_IG"} 
      @association = @discipline.associations.create!(@attr)
    end
    it "should have a unique name" do
      association2 = @discipline.associations.new(@not_attr.merge(:name => "Infogroep"))
      association2.should_not be_valid
    end
    it "should have a unique initials" do
      association2 = @discipline.associations.new(@not_attr.merge(:initials => "IG"))
      association2.should_not be_valid
    end
 end 
  it "should have a discipline" do
    no_discipline_association = Association.new(@attr)
    no_discipline_association.should_not be_valid
  end
  
  describe "relations" do
    before(:each) do
      @association = @discipline.associations.create(@attr)
    end
    it "should have a users attribute" do
      @association.should respond_to(:users)
    end
    it "should have a discipline attribute" do
      @association.should respond_to(:discipline)
    end
    it "should have the correct users in alphabetical order" do
      user1 = Factory(:user)
      user2 = Factory(:user)
      user1.association = @association
      user2.association = @association
      @association.users.should == [user1, user2]
    end
  end
end
