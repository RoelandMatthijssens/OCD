require 'digest'

class User < ActiveRecord::Base
  attr_accessible :last_name, :name, :user_name, :email, :password, :password_confirmation, :permission_group, :salt
  attr_accessor :password
  
  validates :user_name, :presence => true,
    :length => { :within => 3..20 }
  validates :last_name, :presence => true
  validates :password, :presence => true,
    :confirmation => true,
    :length => { :within => 6..40 },
    :on => :create
#  validates :password_confirmation, :presence => true
  validates :name, :presence => true
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, 
    :format => {:with => email_regex}, 
    :uniqueness => {:case_sensitive => false}
  
#  validates :permission_group, :presence => true
  
  validates_uniqueness_of :user_name
  
#  belongs_to :discipline
  has_and_belongs_to_many :permission_groups
  
  has_and_belongs_to_many :guilds
  has_and_belongs_to_many :disciplines
  has_many :orders
  
  default_scope :order => "users.last_name, users.name ASC"
  
  #before_save :encrypt_password
  before_create :encrypt_password
  
  def full_name
    "#{last_name} #{name}"
  end
  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end
  def User.autenticate(user_name, submitted_password)
    user = User.find_by_user_name(user_name)
#    (user && user.has_password?(submitted_password)) ? user : nil
    return nil if user.nil?
    return user if user.has_password?(submitted_password)
  end
  def User.autenticate_with_salt(id, cookie_salt)
    user = User.find_by_id(id)
    (user && user.salt == cookie_salt) ? user : nil
  end
	
	def can?(permission)
		permission_groups.map{|x| x.name}.include?(permission)
	end
private
  def encrypt_password
    self.salt = make_salt if new_record?
    self.encrypted_password = encrypt(password)
  end
  def encrypt(string)
    return secure_hash("#{salt}--#{string}")
  end
  def make_salt
    secure_hash("#{Time.now.utc}--#{password}")
  end
  def secure_hash(string)
    Digest::SHA2.hexdigest(string)
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

