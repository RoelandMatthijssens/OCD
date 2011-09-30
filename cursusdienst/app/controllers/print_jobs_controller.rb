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
    @print_job = PrintJob.new()
    @payed_orders = Order.find(:all, :conditions => ['status = ?', 'payed'])
    @payed_materials = {}
    @payed_orders.each do |order|
      order.material_orders.each do |item|
        if item.material.printable
          if @payed_materials[item.material]
            @payed_materials[item.material] += item.amount
          else
            @payed_materials[item.material] = item.amount
          end
        end
      end
    end
  end

  def create
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
        order.status = 'Ordered'
        order.save!
        end
      flash[:success] = t(:new_print_job_success, :scope => "flash" )
      end
      @payed_materials.each do |k, v|
        @print_job_item = PrintJobItem.new()
        @print_job_item.material = k
        @print_job_item.amount = v
        @print_job_item.print_job = @print_job
        @print_job_item.save!
      end
    else
      flash[:error] = t(:new_print_job_fail, :scope => "flash" )
    end
    redirect_to print_jobs_path
  end

  def logs
    @title = 'Logs'
    @delivered_print_jobs = PrintJob.find(:all, :conditions => ['status = ?', 'delivered'])
  end

end
