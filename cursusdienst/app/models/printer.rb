class Printer < ActiveRecord::Base
  attr_accessible :name
  has_many :price_sets
end
