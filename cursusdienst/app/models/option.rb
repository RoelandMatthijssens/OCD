class Option < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :materials
  validates :name, :presence => true
end
