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
      if current_user.can?('view_all_orders')
        @orders = {}
        orders = Order.active.find(:all, :conditions => ['institute_id = ?', institute.id])
        orders.each do |order|
          if @orders[order.status]
            @orders[order.status] << order
          else
            @orders[order.status] = [order]
          end
        end
      end
    end
  end

  def show
    @title = t(:order_content, :scope => "globals" )
    @order = Order.find(params[:id])
  end

  def search
    deny_access and return unless signed_in?

    str = params[:search]
    substrs = str.split(' ')
    substrs << ''  if substrs.empty?
    if current_user.guilds.empty? || current_user.guilds.first.disciplines.empty?
      flash[:error] = t(:no_institute, :scope => "flash" )
      redirect_to control_panel_path
    else
      institute = current_user.guilds.first.disciplines.first.faculty.institute
      @guild = current_user.guilds.first
      @own_orders = []
      substrs.each { |substr|
        @own_orders =  @own_orders | Order.find(:all, :conditions => ['institute_id = ? and user_id=? and order_key LIKE ?' , institute.id, current_user.id, "%#{substr}%"])
      }
      @orders
      @res = []
      if current_user.can?('view_all_orders')
        @orders = {}
        orders = []
        substrs.each { |substr|
          orders = orders | Order.joins(:user).find(:all, :conditions => ['institute_id = ? and (user_name LIKE ? or email LIKE ? or rolno LIKE ? or order_key LIKE ? or name LIKE ? or last_name LIKE ?)', institute.id, "%#{substr}%", "%#{substr}%", "%#{substr}%", "%#{substr}%", "%#{substr}%", "%#{substr}%"])
        }
        orders.each do |order|
          if @orders[order.status]
            @orders[order.status] << order
          else
            @orders[order.status] = [order]
          end
        end
      end
      render :action => 'index'
    end
  end

  def new
    deny_access and return unless signed_in?
    @order = Order.new()
    @submit = t(:proceed, :scope => "buttons" )
    @back = t(:back, :scope => "buttons")
    @title = t(:verify_order, :scope => "titles")
  end

  def create
    institute = Guild.find_by_initials(request.subdomain).disciplines.first.faculty.institute
    @order = Order.new()
    @order.institute = institute
    @order.user = current_user
    @order.order_key = @order.get_random_string(7)
    current_user.shopping_cart_items.each do |item|
      stock = Stock.find(:all, :conditions => ['guild_id=? AND material_id=?', item.guild.id, item.material.id])
      if stock.empty?
        if not item.material.printable?
          flash[:error] = t(:out_of_stock, :scope => "flash", :material => item.material.name )
          redirect_to orders_path
          return
        end
      elsif stock.first.amount < item.amount && ! item.material.printable
        flash[:error] = t(:not_enough_stock, :scope => "flash", :material => item.material, :available => stock.first.amount, :ordered => item.amount )
        redirect_to orders_path
        return
      end
    end
    #if we end up here, all items in the shoppingcart are available in stock (at least the right amount)
    #all others are printable, so this means we can alter the stock, so that the stock is floating
    current_user.shopping_cart_items.each do |item|
      stock = Stock.find(:all, :conditions => ['guild_id=? AND material_id=?', item.guild.id, item.material.id])
      if stock.any? && stock.first.amount >= item.amount
        stock = stock.first
        stock.amount -= item.amount
        stock.floating += item.amount
        stock.save!
      end
    end
    #all stock amounts are edited to be floating for the amount ordered by the user
    #so we create an order to store the order items in. ( we error if something goes wrong)
    if @order.save
      flash[:success] = t(:new_order_success, :scope => "flash" )
    else
      flash[:error] = t(:new_order_fail, :scope => "flash" )
      redirect_to shopping_cart_items_path
      return
    end
    #we loop over the shoppingcart to get all items, and put them in the order.
    current_user.shopping_cart_items.each do |item|
      x = MaterialOrder.new()
      x.order = @order
      x.guild = item.guild
      x.material = item.material
      x.amount = item.amount
      x.status = "Posted"
      supplyqry = Supply.find(:all, :conditions => ["guild_id = ? and material_id = ?", item.guild.id, item.material.id])
      if supplyqry.any?
        supply = supplyqry.first
        x.price = supply.price * item.amount
      end
      unless x.save!
        #something weird went wrong, so delete the order, and delete the last material_order.
        #TODO we should have a way to update the stock back to before the order was submitted
        x.delete
        @order.delete
        flash[:error] = t(:material_added_to_order_fail, :scope => "flash", :material => item.material.name)
        return
      end
      #all items are tossed from the shopping cart to the order, so we can delete all items in the cart,
      item.delete
    end
    redirect_to my_orders_orders_path
  end

  def mark_as
    @order = Order.find(params[:id])
    status = params[:status_to]
    @order.material_orders.each do |material_order|
      material_order.status = status
      material_order.save!
    end
    if params[:status_to] == 'Payed'
      @order.payment_type = params[:payment_type]
      @order.save
      OrderMailer.payment_ok(@order).deliver
    elsif params[:status_to] == 'Ready'
      @order.label = params[:label]
      Order.set_next_label params[:label]
      @order.save
      OrderMailer.order_ready(@order).deliver
    end
    #OrderMailer.payment_ok(@order.user).deliver
    redirect_to orders_path
  end

  def mark_as_payed
    @order = Order.find(params[:id])
    @order.status = 'Payed'
    @order.save!
    OrderMailer.payment_ok(@order.user).deliver
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
    @guild = Guild.find_by_initials(request.subdomain)
    orders = Order.find(:all, :conditions => ['user_id=?', current_user.id])
    orders.each do |order|
      if @orders[order.status]
        @orders[order.status] << order
      else
        @orders[order.status] = [order]
      end
    end
  end

  def process_orders
    @title = t(:process_orders, :scope => "titles" )
    @label = Order.get_label # todo label is changed EVERY time
    @orders = []
    orders = Order.find(:all)
    orders.each do |order|
      if order.status == "Delivered"
        @orders << order
      end
    end
  end
end
