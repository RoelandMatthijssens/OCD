class PrintersController < ApplicationController
  def index
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_printers')
    @title = t(:all_printers , :scope => "titles" )
    @printers = Printer.all
  end

  def new
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_printers')
    @title = t(:new_printer, :scope => "titles" )
    @printer = Printer.new
  end

  def create
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_printers')
    @printer = Printer.new(params[:printer])
    if @printer.save
      flash[:success] = t(:new_printer_success, :scope => "flash")
      redirect_to @printer
    else
      flash[:error] = t(:new_printer_fail, :scope => "flash")
      render :action => 'new'
    end
  end

  def show
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_printers')
    @printer = Printer.find(params[:id])
  end

  def edit
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_printers')
    @title = t(:edit_printer, :scope => "titles" )
    @printer = Printer.find(params[:id])
    @submit = t(:update_printer, :scope => "buttons")
  end

  def update
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_printers')
    @printer = Printer.find(params[:id])
    if @printer.update_attributes(params[:printer])
      flash[:success] = t(:update_printer_success, :scope => "flash")
      redirect_to @printer
    else
      render :action => 'edit'
    end
  end

  def destroy
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('delete_printers')
  end
end
