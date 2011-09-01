class Stock < ActiveRecord::Base

	belongs_to :guild
	belongs_to :material

	validates :amount, :presence => true
	validates :typee, :presence => true

end
