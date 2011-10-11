class PrintJobsController < ApplicationController

  def index
    deny_access unless signed_in?
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
    @printed_print_jobs = PrintJob.active.find(:all, :conditions => ['status = ?', 'printed'])
    @ordered_print_jobs = PrintJob.active.find(:all, :conditions => ['status = ?', 'ordered'])
  end

  def new
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_print_jobs')
    @title = t(:new_print_job, :scope => "titles" )
    @submit = t(:send_print_job, :scope => "buttons")
    get_sorted_orders "Payed"
  end

  def create
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_print_jobs')
    @print_job = PrintJob.new
    set_material_orders_attributes params[:print_job][:material_orders_attributes]
    total_price = 0
    material_orders_ids = params[:print_job][:material_orders_attributes]
    material_orders_ids.each do |key, id|
      id = id[:id]
      material_order = MaterialOrder.find(id)
      material = material_order.material
      guild = material_order.guild
      supply = Supply.find(:first, :conditions => ["material_id=? AND guild_id = ?", material.id, guild.id])
      unless supply.nil?
        total_price += supply.buy_price
      end
    @print_job.price = total_price
    end
    if @print_job.save!
      set_material_orders_status @print_job, "Ordered"
      flash[:succes] = t(:print_job_send, :scope => "flash" )
    else
      flash[:error] = t(:print_job_not_send, :scope => "flash" )
    end
    @title = t(:new_print_job, :scope => "titles" )
    @submit = t(:send_print_job, :scope => "buttons")
    get_sorted_orders "Payed"
    render 'new'
  end

  def orders
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_print_job_orders')
    @title = t(:process, :scope => "titles" )
    @submit_printed = t(:printed_print_job, :scope => "buttons")
    @submit_delivered = t(:delivered_print_job, :scope => "buttons")
    get_sorted_orders "Ordered"
  end

  def deliver
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_print_jobs')
    print_job = PrintJob.find(params[:print_job_id])
    act = params[:commit]
    if act == t(:delivered_print_job, :scope => "buttons")
      set_material_orders_status print_job, "Delivered"
    end
    @title = t(:new_print_job, :scope => "titles" )
    @submit_printed = t(:printed_print_job, :scope => "buttons")
    @submit_delivered = t(:delivered_print_job, :scope => "buttons")
    get_sorted_orders "Ordered"

    render 'orders'
  end

  def logs
    @title = 'Logs'
    @delivered_print_jobs = PrintJob.find(:all, :conditions => ['status = ?', 'delivered'])
  end

  private

  def set_material_orders_attributes material_orders_attributes
    @print_job.material_orders = []
    material_orders_attributes.each_value { |v|
      unless v["id"].empty?
        d = MaterialOrder.find(v["id"])
        @print_job.material_orders << d if d.instance_of? MaterialOrder and v["_destroy"] != "1"
      end
    }
  end

  def set_material_orders_status print_job, status
    print_job.material_orders.each { |material_order|
      material_order.status = status
      material_order.save!
    }
  end

  def get_sorted_orders status
    @payed_order_materials = MaterialOrder.find(:all, :conditions => ['status = ?', status])
    @payed_materials = {}
    @payed_order_materials.each do |order_material|
      material = order_material.material
      print_type = material.print_type
      if @payed_materials[order_material.guild]
        guild = @payed_materials[order_material.guild]
        if guild[print_type]
          type = guild[print_type]
          if type[material]
            type[material] << order_material
          else
            type[material] = [order_material]
          end
        else
          guild[print_type] = {material => [order_material]}
        end
      else
        #first occurence of the guild
        @payed_materials[order_material.guild] = {print_type => {material => [order_material]}}
      end
      #{guild => {type  => {material  => [ordermaterials ]},
      #           type2 => {material2 => [ordermaterials2]}, }}
    end
  end

end
