class Discipline < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :faculty
  has_many :discipline_subjects
  has_many :subjects, :through => :discipline_subjects
  default_scope :order => "disciplines.name ASC"
  
  def institute
    return discipline.faculty.intitute
  end
end
