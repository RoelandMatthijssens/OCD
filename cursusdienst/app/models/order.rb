class Order < ActiveRecord::Base

	belongs_to :user
	belongs_to :guild
  has_many :material_orders
  has_many :materials, :through => :material_orders
end
