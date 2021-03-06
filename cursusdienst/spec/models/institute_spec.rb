require 'spec_helper'

describe Institute do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  subject { Factory(:institute) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:initials) }
  it { should validate_presence_of(:location) }
  
  it { should have_many(:faculties) }
  it { should have_many(:orders) }
  
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:initials) }
  
  it "should create a new instance given valid attributes" do
    @attr = { :name => "Vrije Universiteit Brussel", :initials => "VUB", :location => "pleinlaan zoveel brussel"}
    institute = Institute.new(@attr)
    institute.should be_valid
  end
  
  it "should have the correct faculties in ALPHABETICAL order" do
    institute = Factory(:institute)
    faculty1 = Factory(:faculty)
    faculty2 = Factory(:faculty)
    faculty3 = Factory(:faculty)
    faculty1.name = "bbb"; faculty2.name = "ccc"; faculty3.name = "aaa"
    faculties = [faculty1, faculty2, faculty3]
    faculties.each{|x| x.save; institute.faculties << x}
    
    institute.faculties.should == [faculty3, faculty1, faculty2]
  end
  
  it "should destroy associated faculties" do
    institute = Factory(:institute)
    f1 = Factory(:faculty, :institute => institute)
    f2 = Factory(:faculty, :institute => institute)
    institute.destroy
    [f1, f2].each do |faculty|
      Faculty.find_by_id(faculty.id).should be_nil
    end
  end
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end

# == Schema Information
#
# Table name: institutes
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  initials   :string(255)
#  location   :string(255)
#  created_at :datetime
#  updated_at :datetime
#

