class Permission < ActiveRecord::Base
  attr_accessible :name, :level
  
  validates :name, :level, :presence => true
  validates_uniqueness_of :level
  
  belongs_to :user
#  has_many :users   # does not seem to be correct, should be the other way around
  
end
