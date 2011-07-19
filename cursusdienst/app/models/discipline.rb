class Discipline < ActiveRecord::Base
  attr_accessible :name, :faculty_id, :subjects, :associations
  validates :name, :presence => true, :uniqueness => {:scope => :faculty_id}
  validates :faculty, :presence => true
  belongs_to :faculty
  has_many :teachings
  has_many :associations
  has_many :users
  has_many :subjects, :through => :teachings
  default_scope :order => "disciplines.name ASC"
  
  def institute
    return self.faculty.institute
  end
end

