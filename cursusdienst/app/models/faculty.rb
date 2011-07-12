#      t.string :name

class Faculty < ActiveRecord::Base
  attr_accessible :name, :initials, :institute_id
  validates :name, :presence => true
  validates :initials, :presence => true
  validates :institute_id, :presence => true
  belongs_to :institute
  default_scope :order => "faculties.name ASC"
  has_many :disciplines
end
