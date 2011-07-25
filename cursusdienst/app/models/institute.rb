class Institute < ActiveRecord::Base
  attr_accessible :name, :initials, :location
  
  validates :name, :presence => true
  validates :initials, :presence => true
  validates :location, :presence => true
  
  validates_uniqueness_of :name, :initials
  
  has_many :faculties, :dependent => :destroy
  
#  def users
#    self.faculties.collect{|f| f.users }.flatten
#  end
end
