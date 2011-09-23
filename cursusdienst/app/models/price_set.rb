class PriceSet < ActiveRecord::Base
  attr_accessible :printer_id, :name
  belongs_to :printer
  has_many :prices
  has_many :supplies
  validates :printer, :name, :presence => true
end
