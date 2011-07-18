require 'spec_helper'

describe Material do
  before(:each) do
    @subject = Factory(:subject)
    @attr = {:name => "material_name"}
  end
  it "should create a new instance given valid attributes" do
    @subject.materials.create!(@attr)
  end
  it "should have a name" do
    material = @subject.materials.new(@attr.merge(:name => ""))
    material.should_not be_valid
  end
  it "should have a subject" do
    material = Material.new(@attr)
    material.should_not be_valid
  end
  describe "subject relations" do
    before(:each) do
      @subject = Factory(:subject)
      @material = @subject.materials.new(@attr)
    end
    it "should have a subject attribute" do
      @material.should respond_to(:subject)
    end
    it "should have the right associated subject" do
      @material.subject.should == @subject
    end
  end
end
