class Permissions < ActiveRecord::Base
  attr_accessible :name, :level
  
  validates :name, :level, :presence => true
  validates_uniqueness_of :level
  
  has_many :user
  
end
