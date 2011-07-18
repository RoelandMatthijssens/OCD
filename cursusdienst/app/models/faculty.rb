#      t.string :name

class Faculty < ActiveRecord::Base
  attr_accessible :name, :initials, :institute_id
  validates :name, :presence => true, :uniqueness => {:scope => :institute_id}
  validates :initials, :presence => true, :uniqueness => {:scope => :institute_id}
  validates :institute_id, :presence => true
  belongs_to :institute
  default_scope :order => "faculties.name ASC"
  has_many :disciplines
  
  def full_name
    "#{institute.initials}: #{name}"
  end
  
end
