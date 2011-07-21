class Subject < ActiveRecord::Base
  attr_accessible :name
  validates :name, :presence => true
  has_many :teachings
  has_many :disciplines, :through => :teachings
#  has_many :materials
  default_scope :order => "subjects.name ASC"
end
