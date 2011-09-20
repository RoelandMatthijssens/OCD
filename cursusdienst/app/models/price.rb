class Price < ActiveRecord::Base
  belongs_to :price_set
  belongs_to :extra_option
end
