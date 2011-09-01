class PrintJobsController < ApplicationController

	def index
		@print_jobs = PrintJob.all()
	end

	def new
		@payed_orders = Order.find(:all, :conditions => ['status = ?', 'payed'])
		@payed_materials = {}
		@payed_orders.each do |order|
			order.material_orders.each do |item|
				if @payed_materials[item.material]
					@payed_materials[item.material] += item.amount
				else
					@payed_materials[item.material] = item.amount
				end
			end
		end
	end

end
