class OrdersController < ApplicationController

	def index
		deny_access and return unless signed_in?

		@title = t(:all_orders, :scope => "titles" )
		if current_user.guilds.empty? || current_user.guilds.first.disciplines.empty?
			flash[:error] = t(:no_institute, :scope => "flash" )
			redirect_to control_panel_path
		else
			institute = current_user.guilds.first.disciplines.first.faculty.institute
			@own_orders = Order.find(:all, :conditions => ['institute_id = ? and user_id=? and status!=?' , institute.id, current_user.id, 'Ready'])
			if current_user.can?('view_all_orders')
				@orders = Order.find(:all, :conditions => ['institute_id = ?', institute.id])
			end
		end
	end

	def new
		deny_access and return unless signed_in?
		@order = Order.new()
		@submit = t(:proceed, :scope => "buttons" )
	end

	def create
		if not (params[:payment] || ['cash', 'transfer'].include?(params[:payment]))
			flash[:error] = t(:no_payment_option, :scope => "flash" )
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
				flash[:success] = t(:new_order_success, :scope => "flash" )
			else
				flash[:error] = t(:new_order_fail, :scope => "flash" )
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
					flash[:error] = t(:material_added_to_order_fail, :scope => "flash", :material => item.material.name)
				end
			end
			redirect_to orders_path
		end
	end

	def mark_as_payed
		@order = Order.find(params[:id])
		@order.status = 'Payed'
		@order.save!
		redirect_to orders_path
	end

	def logs
		institute = current_user.guilds.first.disciplines.first.faculty.institute
		@orders = Order.find(:all, :conditions => ['institute_id = ? and user_id=? and status=?' , institute.id, current_user.id, 'Ready'])
		@all_orders = Order.find(:all, :conditions => ['status=?' , 'Ready'])
	end
end
