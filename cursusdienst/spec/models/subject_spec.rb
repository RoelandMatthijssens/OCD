require 'spec_helper'

describe Subject do
  before(:each) do
    @attr = {
      :name => "Wiskunde"
      }
  end
  
  it "should create a new instance given the correct attributes" do
    Subject.create!(@attr)
  end
  it "should require a name" do
    subject = Subject.new(@attr.merge(:name => ""))
    subject.should_not be_valid
  end
end
