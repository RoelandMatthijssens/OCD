class Subject < ActiveRecord::Base
  attr_accessible :name
  has_many :discipline_subjects
  has_many :disciplines, :through => :discipline_subjects
  validates :name, :presence => true
end
