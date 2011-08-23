require 'spec_helper'

describe User do
  before do
    @old_silence_config = ::ActiveSupport::Deprecation.silenced
    ::ActiveSupport::Deprecation.silenced = true
  end
  
  subject { Factory(:user) }
  
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:user_name) }
  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:user_name) }
  
  it { should ensure_length_of(:user_name).is_at_least(3).is_at_most(20) }
  
  it { should have_and_belong_to_many(:permission_groups) }
  it { should have_and_belong_to_many(:guilds)}
  it { should have_and_belong_to_many(:disciplines)}
  it { should respond_to(:encrypted_password) }
  it { should have_many(:sales) }
  it { should have_many(:materials).through(:sales) }
  it { should have_many (:orders) }
  
  
  describe "other tests" do
    before(:each) do
      @permission_group = Factory(:permission_group)
      @attr = {
        :last_name => 'user last_name',
        :name => 'user name',
        :user_name  => 'user user_name',
        :password => 'user password',
        :password_confirmation => 'user password',
        :email => 'useremail@mail.com'
        }
      @user = User.new(@attr)
      @user.permission_groups << @permission_group
    end
    it "should create a new instance given valid attributes" do
      user = User.new(@attr)
      user.permission_groups << @permission_group
      user.should be_valid
    end
    it "should set a encrypted password" do
      @user.save
      @user.encrypted_password.should_not be_blank
    end
    it "should have the correct guilds in ALPHABETICAL order" do
      user = Factory(:user)
      guild1 = Factory(:guild)
      guild2 = Factory(:guild)
      guild3 = Factory(:guild)
      guild1.name = "bbb"; guild2.name = "ccc"; guild3.name = "aaa"
      guilds = [guild1, guild2, guild3]
      guilds.each{|x| x.save; user.guilds << x}
      user.guilds.should == [guild3, guild1, guild2]
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
        @valid_addresses = %w[user@foo.com THE_USER@foo.bar.org first.last@foo.jp]
        @invalid_addresses = %w[user@foo,com user_at_foo.org example.user@foo.]
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
        user.permission_groups << @permission_group
        user.save!
        user_with_duplicate_email = User.new(@attr.merge(:user_name => 'blub'))
        user_with_duplicate_email.permission_groups << @permission_group
        user_with_duplicate_email.should_not be_valid
      end
    end
    describe "password encryption" do
      before(:each) do
        @user.save
      end
      describe "has_password? method" do
        it "should be true if the passwords match" do
          @user.has_password?(@attr[:password]).should be_true
        end
        it "should be false if the passwords don't match" do
          @user.has_password?("invalid").should be_false
        end
      end
      describe "authentication method" do
        it "should return nil on password/user_name mismatch" do
          wrong_pass_user = User.autenticate(@attr[:user_name], "wrong password")
          wrong_pass_user.should be_nil
        end
        it "should return nil when user_name not found" do
          wrong_name_user = User.autenticate("wrong_user_name", @attr[:password])
          wrong_name_user.should be_nil
        end
        it "should return a user when succesfull" do
          success_user = User.autenticate(@attr[:user_name], @attr[:password])
          success_user.should == @user
        end
      end
    end
  end
  
  after do
    ::ActiveSupport::Deprecation.silenced = @old_silence_config
  end
end

# == Schema Information
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  user_name           :string(255)
#  rolno               :integer(4)
#  email               :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#  permission_group_id :integer(4)
#  name                :string(255)
#  last_name           :string(255)
#  password            :string(255)
#  encrypted_password  :string(255)
#

