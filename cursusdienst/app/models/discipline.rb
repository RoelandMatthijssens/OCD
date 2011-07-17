class Discipline < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :faculty
  has_many :teachings
  has_many :subjects, :through => :teachings
  default_scope :order => "disciplines.name ASC"
  
  def institute
    return discipline.faculty.intitute
  end
end
