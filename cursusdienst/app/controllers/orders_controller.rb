class OrdersController < ApplicationController

	def index
		deny_access and return unless signed_in?

		@title = "Orders"
		if current_user.guilds.empty? || current_user.guilds.first.disciplines.empty?
			flash[:error] = "unable to associate user with institute"
			redirect_to control_panel_path
		else
			institute = current_user.guilds.first.disciplines.first.faculty.institute
			@own_orders = Order.find(:all, :conditions => ['institute_id = ? and user_id=?', institute.id, current_user.id])
			if current_user.can?('view_all_orders')
				@orders = Order.find(:all, :conditions => ['institute_id = ?', institute.id])
			end
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
			institute = current_user.guilds.first.disciplines.first.faculty.institute
			@order = Order.new()
			@order.status = "posted"
			@order.payment_type = params[:payment]
			@order.institute = institute
			@order.user = current_user
			@order.order_key = 'RANDOM STRING O_o'
			if @order.save!
				flash[:success] = 'shopping cart emptied, and added to orders'
			else
				flash[:error] = 'something went horribly wrong'
			end
			current_user.shopping_cart_items.each do |item|
				x = MaterialOrder.new()
				x.order = @order
				x.guild = item.guild
				x.material = item.material
				x.amount = item.amount
				if x.save!
					item.delete
				else
					message << "something bad happened with material #{item.material.name}"
				end
			end
			redirect_to orders_path
		end
	end

	def mark_as_payed
		@order = Order.find(params[:id])
		@order.status = 'payed'
		@order.save!
		redirect_to orders_path
	end
end
