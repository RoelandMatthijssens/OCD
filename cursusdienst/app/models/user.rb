class User < ActiveRecord::Base
  attr_accessible :last_name, :name, :user_name, :email, :permission_group, :password
  
  validates :user_name, :presence => true
  validates :last_name, :presence => true
  validates :password, :presence => true
  validates :name, :presence => true
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, :presence => true, 
    :format => {:with => email_regex}, 
    :uniqueness => {:case_sensitive => false}
  
  validates :permission_group, :presence => true
  
  validates_uniqueness_of :user_name
  
  belongs_to :discipline
  belongs_to :permission_group
  
  has_and_belongs_to_many :associations
  has_and_belongs_to_many :disciplines
  
  default_scope :order => "users.last_name, users.name ASC"
  
  def full_name
    "#{last_name} #{name}"
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

