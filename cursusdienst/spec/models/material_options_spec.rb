require 'spec_helper'

describe MaterialOption do
  before(:each) do
    @material = Factory(:material)
    @attr = {:key => "version", :value => "1.1"}
  end
  it "should create a new instance given correct attributes" do
    @material.materialOptions.create!(@attr)
  end
  it "should have a key" do
    material_option = @material.materialOptions.new(@attr.merge(:key => ""))
    material_option.should_not be_valid
  end
  it "should have a value" do
    material_option = @material.materialOptions.new(@attr.merge(:value => ""))
    material_option.should_not be_valid
  end
  it "should have a material" do
    material_option = MaterialOption.new(@attr)
    material_option.should_not be_valid
  end
  it "should have a unique key given a material_id" do
    material = Factory(:material)
    material_option1 = material.materialOptions.create(:key => "something", :value => "eek")
    material_option2 = material.materialOptions.new(:key => "something", :value => "not-eek")
    material_option2.should_not be_valid
  end
  it "should have a material" do
    material_option = MaterialOption.new(@attr)
    material_option.should respond_to(:material)
  end
  it "should have the correct material" do
    material = Factory(:material)
    material_option = material.materialOptions.new(@attr)
    material_option.material.should == material
  end
end
