class PrintersController < ApplicationController
  def index
    @title = t(:all_printers , :scope => "titles" )
    @printers = Printer.all
  end

  def new
    @title = t(:new_printer, :scope => "titles" )
    @printer = Printer.new
  end

  def create
    @printer = Printer.new(params[:printer])
    if @printer.save
      flash[:notice] = t(:new_printer_success, :scope => "flash")
      redirect_to @printer
    else
      flash[:notice] = t(:new_printer_fail, :scope => "flash")
      render :action => 'new'
    end
  end

  def show
    @printer = Printer.find(params[:id])
  end

  def edit
    @title = t(:edit_printer, :scope => "titles" )
    @printer = Printer.find(params[:id])
    @submit = t(:update_printer, :scope => "buttons")
  end

  def update
    @printer = Printer.find(params[:id])
    if @printer.update_attributes(params[:printer])
      flash[:notice] = t(:update_printer_success, :scope => "flash")
      redirect_to @printer
    else
      render :action => 'edit'
    end
  end

  def destroy

  end
end
