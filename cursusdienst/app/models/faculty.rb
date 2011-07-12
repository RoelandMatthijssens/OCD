#      t.string :name

class Faculty < ActiveRecord::Base
  validates :name, :presence => true
  belongs_to :institute
  default_scope :order => "faculties.name ASC"
end
