class User < ActiveRecord::Base
  attr_accessible :full_name, :user_name, :email, :permission_group
  
  validates :full_name, :presence => true
  validates :user_name, :presence => true
  
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
  
  default_scope :order => "users.full_name ASC"
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

