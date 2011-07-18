class Subject < ActiveRecord::Base
  attr_accessible :name
  has_many :teachings
  has_many :disciplines, :through => :teachings
  has_many :materials
  validates :name, :presence => true
  default_scope :order => "subjects.name ASC"
end
