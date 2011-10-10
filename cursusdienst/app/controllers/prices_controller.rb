class PricesController < ApplicationController
  def index
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_prices')
    @title = t(:all_prices, :scope => "titles" )
    @prices = Price.active.all()
  end

  def new
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_prices')
    @title = t(:new_price, :scope => "titles" )
    if params[:price_set_id]
      @price = PriceSet.find(params[:price_set_id]).prices.new
    else
      @price = Price.new()
    end
  end

  def create
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_prices')
    @price = Price.new(params[:price])
    if @price.save
      flash[:success] = t(:new_price_success, :scope => "flash" )
      redirect_to @price
    else
      flash[:error] = t(:new_price_fail, :scope => "flash" )
      render :action => 'new'
    end
  end

  def show
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_prices')
    @price = Price.find(params[:id])
  end

  def edit
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_prices')
    @title = t(:edit_price, :scope => "titles" )
    @price = Price.find(params[:id])
    @submit = t(:update_price, :scope => "buttons" )
  end

  def update
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_prices')
    @price = Price.find(params[:id])
    if @price.update_attributes(params[:price])
      flash[:success] = t(:update_price_success, :scope => "flash" )
      redirect_to @price
    else
      redirect_to :action => 'edit'
    end
  end

  def destroy
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('delete_prices')

  end
end
