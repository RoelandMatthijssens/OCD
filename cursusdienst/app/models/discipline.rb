class Discipline < ActiveRecord::Base
  attr_accessible :name, :faculty_id, :associations
  validates :name, :presence => true, :uniqueness => {:scope => :faculty_id}
  validates :faculty, :presence => true
  
  belongs_to :faculty
  has_and_belongs_to_many :associations
  has_many :teachings
  has_many :subjects, :through => :teachings
  
#  default_scope :order => "disciplines.name ASC"
end

