class Discipline < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :faculty
  has_and_belongs_to_many :subjects, :class_name => "discipline", :join-table => "discipline_subjects"
  default_scope :order => "disciplines.name ASC"
  
  def institute
    return discipline.faculty.intitute
  end
end
