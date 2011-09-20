class Price < ActiveRecord::Base
  belongs_to :price_set
  belongs_to :option

  validates :price_set, :presence => true
  validates :option, :presence => true
end
