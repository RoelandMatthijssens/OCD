class ExtraOption < ActiveRecord::Base
  attr_accessible :name
  has_and_belongs_to_many :materials
  has_many :prices
  validates :name, :presence => true
end
