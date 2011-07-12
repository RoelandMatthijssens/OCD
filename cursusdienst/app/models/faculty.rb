#      t.string :name

class Faculty < ActiveRecord::Base
  validates :name, :presence => true
  validates :initials, :presence => true
  belongs_to :institute
  default_scope :order => "faculties.name ASC"
  has_many :disciplines
end
