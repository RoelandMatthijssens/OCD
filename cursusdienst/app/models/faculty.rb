#      t.string :name

class Faculty < ActiveRecord::Base
  attr_accessible :name, :initials, :full_name#, :institute
  validates :name, :presence => true#, :uniqueness => {:scope => :institute_id}
  validates :initials, :presence => true#, :uniqueness => {:scope => :institute_id}
  validates :institute, :presence => true
#  default_scope :order => "faculties.name ASC"
  has_many :disciplines, :dependent => :destroy
  belongs_to :institute

  def full_name
    "#{institute.initials}: #{name}"
  end
end
