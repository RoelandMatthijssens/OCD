class OrdersController < ApplicationController

	def index
		deny_access and return unless signed_in?

		@title = "Orders"
		if current_user.guilds.empty? || current_user.guilds.first.disciplines.empty?
			flash[:error] = "unable to associate user with institute"
			redirect_to control_panel_path
		else
			institute = current_user.guilds.first.disciplines.first.faculty.institute
			@orders = Order.find(:all,  :conditions => ['institute_id = ?', institute.id])
		end
	end

	def new
		@title = "verify the order"
		deny_access and return unless signed_in?
		@order = Order.new()
    @submit = "Proceed"
	end

	def create
		if not (params[:payment] || ['cash', 'transfer'].include?(params[:payment]))
			flash[:error] = 'no payment option given'
			redirect_to new_order_path
		else
			@order = Order.new()
			materials = []
			current_user.shopping_cart_items.each do |item|
				materials << item.material
			end
			institute = current_user.guilds.first.disciplines.first.faculty.institute
			@order.materials = materials
			@order.status = "posted"
			@order.payment_type = params[:payment]
			@order.institute = institute
			@order.user = current_user
			
			if @order.save!
				flash[:success] = 'shopping cart emptied, and added to orders'
			else
				flash[:error] = 'something went horribly wrong'
			end
			current_user.shopping_cart_items.each do |item|
				item.delete
			end
			redirect_to shopping_cart_items_path
		end
	end
end
