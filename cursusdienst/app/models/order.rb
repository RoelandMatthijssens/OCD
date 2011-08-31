class Order < ActiveRecord::Base

	belongs_to :user
	belongs_to :guild
	belongs_to :institute
  has_many :material_orders
  has_many :materials, :through => :material_orders

  validates :payment_type, :presence => true
  validates :guild, :presence => true
  validates :institute, :presence => true
  validates :user, :presence => true
end
