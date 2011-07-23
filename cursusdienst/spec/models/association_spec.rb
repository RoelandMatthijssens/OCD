require 'spec_helper'

describe Association do
  subject { Factory(:association) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:initials) }
  it { should validate_presence_of(:disciplines) }
  
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:initials) }
  
  it { should have_and_belong_to_many(:users)}
  it { should have_and_belong_to_many(:disciplines) }
  
  it "should list the users in ALPHABETICAL order" do
    user1 = Factory(:user)
    user2 = Factory(:user)
    association = Factory(:association)
    
    association.users << user2
    association.users << user1
    
    association.users.should == [user1, user2]
  end
  
  it "should create a new instance given valid attributes" do
    discipline = Factory(:discipline)
    @attr = { :name => 'Infogroep', :initials => 'IG' }
    association = Association.new(@attr)
    association.disciplines << discipline
    association.should be_valid
  end
  
  it "should have the correct users in alphabetical order" do
    association = Factory(:association)
    u1 = Factory(:user)
    u2 = Factory(:user)
    u3 = Factory(:user)
    u1.full_name = "bbb"; u2.full_name = "ccc"; u3.full_name = "aaa"
    users = [u1, u2, u3]
    users.each{|x| x.save; association.users << x}
    
    association.users.should == [u3, u1, u2]
  end
end

# == Schema Information
#
# Table name: associations
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  initials      :string(255)
#  discipline_id :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

