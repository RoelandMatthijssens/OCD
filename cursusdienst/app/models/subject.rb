class Subject < ActiveRecord::Base
  attr_accessible :name
#  has_many :disciplines_subjects
  has_and_belongs_to_many :disciplines
#  has_many :disciplines, :through => :disciplines_subjects
  validates :name, :presence => true
end
