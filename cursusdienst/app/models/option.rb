class Option < ActiveRecord::Base
  attr_accessible :name, :typee
  has_and_belongs_to_many :materials
  has_many :prices
  validates :name, :presence => true
  validates :typee, :presence => true
end
