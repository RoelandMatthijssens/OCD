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
    @printed_print_jobs = PrintJob.find(:all, :conditions => ['status = ?', 'printed'])
    @ordered_print_jobs = PrintJob.find(:all, :conditions => ['status = ?', 'ordered'])
  end

  def new
    @title = t(:new_print_job, :scope => "titles" )
    @submit = t(:send_print_job, :scope => "buttons")
    @payed_order_materials = MaterialOrder.find(:all, :conditions => ['status = ?', 'payed'])
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

  def create
    @print_job = PrintJob.new
    
    set_material_orders_attributes params[:print_job][:material_orders_attributes]
    #save_res = @print_job.save!
    if @print_job.save!
      set_material_orders_status @print_job
      flash[:succes] = t(:print_job_send, :scope => "flash" )
    else
      flash[:error] = t(:print_job_not_send, :scope => "flash" )
    end
    
    @title = t(:new_print_job, :scope => "titles" )
    @submit = t(:send_print_job, :scope => "buttons")
    @payed_order_materials = MaterialOrder.find(:all, :conditions => ['status = ?', 'payed'])
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
    render 'new'
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
  
  def set_material_orders_status print_job
    print_job.material_orders.each { |material_order|
      material_order.status = "Ordered"
      material_order.save!
    }
  end

end
