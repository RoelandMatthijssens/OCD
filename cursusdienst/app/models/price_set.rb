class PriceSet < ActiveRecord::Base
  belongs_to :printer
  has_many :prices
  validates :printer, :presence => true
end
