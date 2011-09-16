class PriceSet < ActiveRecord::Base
  belongs_to :printer
  has_many :prices
end
