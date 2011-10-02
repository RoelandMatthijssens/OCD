class MaterialOrder < ActiveRecord::Base

  attr_accessible :material, :order, :guild, :price, :material_id, :order_id, :guild_id, :amount, :status

  belongs_to :material
  belongs_to :order
  belongs_to :guild

  validates :material, :presence => true
  validates :order, :presence => true
  validates :guild, :presence => true
  validates :amount, :presence => true
  validates :price, :presence => true
  validates :status, :presence => true
end
