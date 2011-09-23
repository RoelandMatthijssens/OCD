class Printer < ActiveRecord::Base
  attr_accessible :name
  has_many :price_sets
  
  validates :name, :presence => true

end
