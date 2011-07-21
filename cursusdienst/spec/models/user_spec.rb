require 'spec_helper'

describe User do
  subject { Factory(:user) }
  
  it { should validate_presence_of(:full_name) }
  it { should validate_presence_of(:user_name) }
  it { should validate_presence_of(:email) }
  it { should validate_presence_of(:permission_group) }
  it { should validate_uniqueness_of(:user_name) }
  
  it { should belong_to(:permission_group) }
  it { should have_and_belong_to_many(:associations)}
  it { should have_and_belong_to_many(:disciplines)}
  
  it "should create a new instance given valid attributes" do
    @permission_group = Factory(:permission_group)
    @attr = {
      :full_name => 'user full_name',
      :user_name  => 'user user_name',
      :email => 'user email'
      }
    user = User.new(@attr)
    user.permission_group = @permission_group
    user.should be_valid
  end
  
  it "should have the correct associations in ALPHABETICAL order" do
    user = Factory(:user)
    ass1 = Factory(:association)
    ass2 = Factory(:association)
    ass3 = Factory(:association)
    ass1.name = "bbb"; ass2.name = "ccc"; ass3.name = "aaa"
    associations = [ass1, ass2, ass3]
    associations.each{|x| x.save; user.associations << x}
    user.associations.should == [ass3, ass1, ass2]
  end
  
  it "should have the correct disciplines in ALPHABETICAL order" do
    user = Factory(:user)
    discipline1 = Factory(:discipline)
    discipline2 = Factory(:discipline)
    discipline3 = Factory(:discipline)
    discipline1.name = "bbb"; discipline2.name = "ccc"; discipline3.name = "aaa"
    disciplines = [discipline1, discipline2, discipline3]
    disciplines.each{|x| x.save; user.disciplines << x}
    user.disciplines.should == [discipline3, discipline1, discipline2]
  end
end
