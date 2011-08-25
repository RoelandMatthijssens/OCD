class ShoppingCartItem < ActiveRecord::Base
  attr_accessible :amount
	belongs_to :user
	belongs_to :material

  validates :amount, :presence => true
  validates :user, :presence => true
  validates :material, :presence => true
	
end
