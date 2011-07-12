#      t.string :name

class Faculty < ActiveRecord::Base
  validates :name, :presence => true, :uniqueness => {:scope => :institute_id}
  validates :initials, :presence => true, :uniqueness => {:scope => :institute_id}
  belongs_to :institute
  default_scope :order => "faculties.name ASC"
  has_many :disciplines
end
