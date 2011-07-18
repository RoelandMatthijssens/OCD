require 'spec_helper'

describe Subject do
  before(:each) do
    @attr = {
      :name => "Statestiek"
      }
  end
  
  it "should create a new instance given the correct attributes" do
    Subject.create!(@attr)
  end
  it "should require a name" do
    subject = Subject.new(@attr.merge(:name => ""))
    subject.should_not be_valid
  end
  it "should have a unique name given a institute"
  
  it "should have a disciplines attribute" do
    subject.should respond_to(:disciplines)
  end
  it "should have the correct disciplines in alphabetical order" do
    d1 = Factory(:discipline)
    d2 = Factory(:discipline)
    s = Subject.create(@attr)
    d1.subjects << s
    d2.subjects << s
    s.disciplines.should == [d1, d2]
  end
end
