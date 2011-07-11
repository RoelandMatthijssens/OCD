#      t.string :name
#      t.string :initials
#      t.string :location

class Institute < ActiveRecord::Base
  attr_accessible :name, :initials, :location
  
  validates :name, :presence => true
  validates :initials, :presence => true
  validates :location, :presence => true
  
  validates_uniqueness_of :name, :initials
  
  has_many :users
  has_many :faculties
end
