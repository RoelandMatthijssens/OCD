class Price < ActiveRecord::Base
  belongs_to :price_set
  belongs_to :extra_option

  validates :price_set, :presence => true
  validates :extra_option, :presence => true
end
