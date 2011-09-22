class PriceSet < ActiveRecord::Base
  belongs_to :printer
  has_many :prices
  has_many :supplies
  validates :printer, :presence => true
end
