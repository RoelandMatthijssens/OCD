class Price < ActiveRecord::Base
  attr_accessible :typee, :option, :price_set
  belongs_to :price_set
  belongs_to :option

  validates :price_set, :presence => true
  validates :option, :presence => true
  validates :typee, :presence => true
  validates :amount, :presence => true
end
