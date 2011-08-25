require 'spec_helper'

describe Subject do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  subject { Factory(:subject) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:year) }
  it { should validate_presence_of(:year_type) }
  it { should have_many(:teachings) }
  it { should have_many(:disciplines).through(:teachings) }
  
  it "should create a new instance given the correct attributes" do
    @attr = { :name => "Statestiek" }
    subject = Subject.new(@attr)
    subject.should be_valid
  end
  
#  it "should have the correct disciplines in ALPHABETICAL order" do
#    subject = Factory(:subject)
#    discipline1 = Factory(:discipline)
#    discipline2 = Factory(:discipline)
#    discipline3 = Factory(:discipline)
#    discipline1.name = "bbb"; discipline2.name = "ccc"; discipline3.name = "aaa"
#    disciplines = [discipline1, discipline2, discipline3]
#    disciplines.each{|x| x.save; subject.disciplines << x}
#    
#    subject.disciplines.should == [discipline3, discipline1, discipline2]
#  end
  
  it "should have the correct materials in ALPHABETICAL order" do
    subject = Factory(:subject)
    material1 = Factory(:material)
    material2 = Factory(:material)
    material3 = Factory(:material)
    material1.name = "bbb"; material2.name = "ccc"; material3.name = "aaa"
    materials = [material1, material2, material3]
    materials.each{|x| x.save; subject.materials << x}
    
    subject.materials.should == [material3, material1, material2]
  end
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end

# == Schema Information
#
# Table name: subjects
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

