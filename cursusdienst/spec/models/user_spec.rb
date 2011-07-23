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
      :email => 'useremail@mail.com'
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
  
  describe "email validation" do
    before(:each) do
      @attr = {
        :full_name => 'user full_name',
        :user_name  => 'user user_name',
        :email => 'useremail@mail.com'
      }
      @valid_addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
      @invalid_addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
      @permission_group = Factory(:permission_group)
      @user = User.new(@attr)
      @user.permission_group = @permission_group
    end
    it "should accept valid email addresses" do
      @valid_addresses.each do |address|
        @user.email = address
        @user.should be_valid
      end
    end
    it "should not accept invalid email addresses" do
      @invalid_addresses.each do |address|
        @user.email = address
        @user.should_not be_valid
      end
    end
    it "should reject email addresses identical up to case" do
      upcased_email = @attr[:email].upcase
      user = User.new(@attr.merge(:email => upcased_email))
      user.permission_group = @permission_group
      user.save!
      user_with_duplicate_email = User.new(@attr.merge(:user_name => 'blub'))
      user_with_duplicate_email.permission_group = @permission_group
      user_with_duplicate_email.should_not be_valid
    end

  end
end

# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  full_name           :string(255)
#  user_name           :string(255)
#  rolno               :integer(4)
#  email               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  permission_group_id :integer(4)
#

