class Subject < ActiveRecord::Base
  attr_accessible :name, :materials
  validates :name, :presence => true
  has_many :teachings
  has_many :disciplines, :through => :teachings
  has_many :materials
  default_scope :order => "subjects.name ASC"

  accepts_nested_attributes_for :disciplines
end

# == Schema Information
#
# Table name: subjects
#
#  id         :integer(4)      not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

