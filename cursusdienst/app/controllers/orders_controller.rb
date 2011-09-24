class OrdersController < ApplicationController

  def index
    deny_access and return unless signed_in?
    @title = t(:all_orders, :scope => "titles" )
    if current_user.guilds.empty? || current_user.guilds.first.disciplines.empty?
      flash[:error] = t(:no_institute, :scope => "flash" )
      redirect_to control_panel_path
    else
      institute = current_user.guilds.first.disciplines.first.faculty.institute
      @guild = current_user.guilds.first
      @own_orders = Order.find(:all, :conditions => ['institute_id = ? and user_id=? and status!=?' , institute.id, current_user.id, 'Ready'])
      if current_user.can?('view_all_orders')
        @orders = Order.find(:all, :conditions => ['institute_id = ?', institute.id])
      end
    end
  end
  
  def search
    deny_access and return unless signed_in?
    
    substr = params[:search]
    if current_user.guilds.empty? || current_user.guilds.first.disciplines.empty?
      flash[:error] = t(:no_institute, :scope => "flash" )
      redirect_to control_panel_path
    else
      institute = current_user.guilds.first.disciplines.first.faculty.institute
      @guild = current_user.guilds.first
      @own_orders = Order.find(:all, :conditions => ['institute_id = ? and user_id=? and status!= ? and order_key LIKE ?' , institute.id, current_user.id, 'Ready', "%#{substr}%"])
      if current_user.can?('view_all_orders')
        @orders = Order.joins(:user).find(:all, :conditions => ['institute_id = ? and status!= ? and (user_name LIKE ? or email LIKE ? or rolno LIKE ? or order_key LIKE ?)', institute.id, 'Ready', "%#{substr}%", "%#{substr}%", "%#{substr}%", "%#{substr}%"])
      end
      render :action => 'index'
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
      @order.status = "Posted"
      @order.payment_type = params[:payment]
      @order.institute = institute
      @order.user = current_user
      @order.order_key = @order.get_random_string(7)
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
    #    unless @order.status == 'Payed'
    @order.status = 'Payed'
    @order.save!
    OrderMailer.payment_ok(@order.user).deliver
    #    end
    redirect_to orders_path
  end

  def logs
    institute = current_user.guilds.first.disciplines.first.faculty.institute
    @orders = Order.find(:all, :conditions => ['user_id=? and status=?', current_user.id, 'Ready'])
    @all_orders = Order.find(:all, :conditions => ['status=?' , 'Ready'])
  end

  def results
    @title = t(:results, :scope => "titles" )
    @orders = Order.find(:all, :conditions => ['status = ?', 'Done'])
    @per_material = {}
    @per_guild = {}
    #@everything = {} #gesorteerd op winst/guild
    @orders.each do |order|
      order.material_orders.each do |item|
        if @per_material[item.material]
          @per_material[item.material] << item
        else
          @per_material[item.material] = [item]
        end
        if @per_guild[item.guild]
          @per_guild[item.guild] << item
        else
          @per_guild[item.guild] = [item]
        end
      end
    end
  end

  def destroy
    @order = Order.find(params[:id])
    @order.status = 'Cancled'
    @order.save!
    redirect_to orders_path
  end

  def my_orders
    @title = t(:my_orders, :scope => "titles" )
    @orders = {}
    orders = Order.find(:all, :conditions => ['user_id=?', current_user.id])
    orders.each do |order|
      if @orders[order.status]
        @orders[order.status] << order
      else
        @orders[order.status] = [order]
      end
    end
  end
end
