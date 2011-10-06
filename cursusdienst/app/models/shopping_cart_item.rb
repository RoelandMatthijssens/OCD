class ShoppingCartItem < ActiveRecord::Base
  attr_accessible :amount
  belongs_to :user
  belongs_to :material
  belongs_to :guild

  validates :amount, :presence => true
  validates :user, :presence => true
  validates :material, :presence => true
  validates :guild, :presence => true

  #default_scope :conditions => {:deleted=>false}

end
