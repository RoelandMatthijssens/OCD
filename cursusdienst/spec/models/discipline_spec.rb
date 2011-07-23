require 'spec_helper'

describe Discipline do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  subject { Factory(:discipline) }
  
  it { should validate_presence_of(:name) }
  
  it { should have_and_belong_to_many(:associations)}
  it { should have_and_belong_to_many(:users)}
  
  it { should belong_to(:faculty) }
  
  it { should have_many(:teachings) }
  it { should have_many(:subjects).through(:teachings) }
  
  it { should validate_presence_of(:faculty) }
  
  it "should not allow two disciplines with the same name in a single faculty" do
    faculty = Factory(:faculty)
    @attr = { :name => "name" }
    @not_attr = { :name => "NOT name" }
    discipline1 = faculty.disciplines.create(@attr)
    discipline2 = faculty.disciplines.new(@not_attr.merge(:name => "name"))
    discipline2.should_not be_valid
  end

  it "should create a new instance given valid attributes" do
    faculty = Factory(:faculty)
    @attr = { :name => "Computer Wetenschappen" }
    discipline = Discipline.new(@attr)
    discipline.faculty = faculty
    discipline.should be_valid
  end

  it "should have the correct associations in ALPHABETICAL order" do
    discipline = Factory(:discipline)
    ass1 = Factory(:association)
    ass2 = Factory(:association)
    ass3 = Factory(:association)
    ass1.name = "bbb"; ass2.name = "ccc"; ass3.name = "aaa"
    associations = [ass1, ass2, ass3]
    associations.each{|x| x.save; discipline.associations << x}
    
    discipline.associations.should == [ass3, ass1, ass2]
  end
  
  it "should have the correct users in ALPHABETICAL order" do
    discipline = Factory(:discipline)
    user1 = Factory(:user)
    user2 = Factory(:user)
    user3 = Factory(:user)
    user4 = Factory(:user)
    user1.last_name = "bbb"; user2.last_name = "ccc"; user3.last_name = "aaa"; user4.last_name = "aaa"
    user3.name = "bbb"; user4.name = "aaa"
    users = [user1, user2, user3, user4]
    users.each{|x| x.save; discipline.users << x}
    
    discipline.users.should == [user4, user3, user1, user2]
  end
  
  it "should have the correct subjects in ALPHABETICAL order" do
    discipline = Factory(:discipline)
    subject1 = Factory(:subject)
    subject2 = Factory(:subject)
    subject3 = Factory(:subject)
    subject1.name = "bbb"; subject2.name = "ccc"; subject3.name = "aaa"
    subjects = [subject1, subject2, subject3]
    subjects.each{|x| x.save; discipline.subjects << x}
    
    discipline.subjects.should == [subject3, subject1, subject2]
  end
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end

# == Schema Information
#
# Table name: disciplines
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  faculty_id :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

