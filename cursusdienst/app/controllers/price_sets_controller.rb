class PriceSetsController < ApplicationController
  def index
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_price_sets')
    @title = t(:all_price_sets, :scope => "titles" )
    @price_sets = PriceSet.active.all
  end

  def new
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_price_sets')
    @title = t(:new_price_set, :scope => "titles" )
    if params[:printer_id]
      @price_set = Printer.find(params[:printer_id]).price_sets.new
    else
      @price_set = PriceSet.new()
    end
  end

  def create
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_price_sets')
    @price_set = PriceSet.new(params[:price_set])
    @printer = Printer.find(params[:printer_id])
    @printer.price_sets << @price_set
    if @price_set.save
      flash[:success] = t(:new_price_set_success, :scope => "flash" )
      redirect_to @price_set
    else
      flash[:error] = t(:new_price_set_fail, :scope => "flash" )
      render :action => 'new'
    end
  end

  def show
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_price_sets')
    @price_set = PriceSet.find(params[:id])
  end

  def edit
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_price_sets')
    @title = t(:edit_price_set, :scope => "titles" )
    @price_set = PriceSet.find(params[:id])
    @submit = t(:update_price_set, :scope => "buttons" )
  end

  def update
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_price_sets')
    @price_set = PriceSet.find(params[:id])
    if @price_set.update_attributes(params[:price_set])
      flash[:success] = t(:update_price_set_success, :scope => "flash" )
      redirect_to @price_set
    else
      render :action => 'edit'
    end
  end

  def destroy

  end
end
