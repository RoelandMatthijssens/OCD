class User < ActiveRecord::Base
  attr_accessible :full_name, :user_name, :email
  
  validates :full_name, :presence => true
  validates :user_name, :presence => true
  validates_uniqueness_of :user_name
  validates :email, :presence => true
  belongs_to :discipline
end
