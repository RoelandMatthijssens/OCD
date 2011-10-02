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
    @print_job = PrintJob.new()
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
    #@print_job = PrintJob.new
    #@print_job.status = 'ordered'
    #if @print_job.save!
      #@payed_ordermaterials = MaterialOrder.find(:all, :conditions => ['status = ?', 'payed'])
      #@payed_materials = {}
      #@payed_order_materials.each do |order_material|
        #if @payed_materials[order_material.guild]
          #if @payed_materials[order_material.guild][order_material.material]
            ##guild already encountered, and material already encountered within the guild
            #@payed_materials[order_material.guild][order_material.material] += order_material.amount
          #else
            ##guild already encountered, but first occurence of the material within the guild
            #@payed_materials[order_material.guild][order_material.material] = order_material.amount
          #end
        #else
          ##first occurence of the guild
          #@payed_materials[order_material.guild] = {}
          #@payed_materials[order_material.guild][order_material.material] = order_material.amount
        #end
      #end

      #end
      #flash[:success] = t(:new_print_job_success, :scope => "flash" )
      #end
      #@payed_materials.each do |k, v|
        #@print_job_item = PrintJobItem.new()
        #@print_job_item.material = k
        #@print_job_item.amount = v
        #@print_job_item.print_job = @print_job
        #@print_job_item.save!
      #end
    #else
      #flash[:error] = t(:new_print_job_fail, :scope => "flash" )
    #end
    #redirect_to print_jobs_path
  end

  def logs
    @title = 'Logs'
    @delivered_print_jobs = PrintJob.find(:all, :conditions => ['status = ?', 'delivered'])
  end

end
