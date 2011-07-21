class User < ActiveRecord::Base
  attr_accessible :full_name, :user_name, :email, :permission_group
  
  validates :full_name, :presence => true
  validates :user_name, :presence => true
  validates :email, :presence => true
  validates :permission_group, :presence => true
  
  validates_uniqueness_of :user_name
  
  belongs_to :discipline
  belongs_to :permission_group
  
  has_and_belongs_to_many :associations
  has_and_belongs_to_many :disciplines
  
  default_scope :order => "users.full_name ASC"
end
