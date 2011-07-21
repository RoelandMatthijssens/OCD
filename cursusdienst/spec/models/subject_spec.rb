require 'spec_helper'

describe Subject do
  subject { Factory(:subject) }
  
  it { should validate_presence_of(:name) }
  it { should have_many(:teachings) }
  it { should have_many(:disciplines).through(:teachings) }
  
  it "should create a new instance given the correct attributes" do
    @attr = { :name => "Statestiek" }
    subject = Subject.new(@attr)
    subject.should be_valid
  end
  
  it "should have the correct disciplines in ALPHABETICAL order" do
    subject = Factory(:subject)
    discipline1 = Factory(:discipline)
    discipline2 = Factory(:discipline)
    discipline3 = Factory(:discipline)
    discipline1.name = "bbb"; discipline2.name = "ccc"; discipline3.name = "aaa"
    disciplines = [discipline1, discipline2, discipline3]
    disciplines.each{|x| x.save; subject.disciplines << x}
    
    subject.disciplines.should == [discipline3, discipline1, discipline2]
  end
  
#  it "should have a materials attribute" do
#    subject = Subject.new(@attr)
#    subject.should respond_to(:materials)
#  end
#  
#  describe "materials associations" do
#    before(:each) do
#      @subject = Factory(:subject)
#      @m1 = Factory(:material, :subject => @subject)
#      @m2 = Factory(:material, :subject => @subject)
#    end
#    it "should have the correct materials in alphabetical order" do
#      @subject.materials.should == [@m1, @m2]
#    end
#    it "should sort the materials based on the name"
#  end
end
