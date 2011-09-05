class PrintJobsController < ApplicationController

	def index
		@print_jobs = PrintJob.all()
	end

	def new
		@print_job = PrintJob.new()
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

	def create
		redirect_to shopping_cart_items_path
		@print_job = PrintJob.new
		@print_job.status = 'ordered'
		if @print_job.save!
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
			@payed_materials.each do |k, v|
				@print_job_item = PrintJobItem.new()
				@print_job_item.material = k
				@print_job_item.amount = v
				@print_job_item.print_job = @print_job
				@print_job_item.save!
			end
		else
			flash[:error] = 'something went horribly wrong'
		end
	end

end
