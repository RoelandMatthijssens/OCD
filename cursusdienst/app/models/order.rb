class Order < ActiveRecord::Base

	belongs_to :user
	belongs_to :institute
  has_many :material_orders
  has_many :materials, :through => :material_orders

  validates :payment_type, :presence => true
  validates :institute, :presence => true
  validates :user, :presence => true
end
