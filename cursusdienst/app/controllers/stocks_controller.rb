class StocksController < ApplicationController
  def index
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_stock') || current_user.can?('view_all_stock')
    @title = t(:stock, :scope => "titles" )
    @guilds = current_user.guilds
  end

  def new
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_stock') || current_user.can?('create_all_stock')
    @stock = Stock.new()
    @title = t(:new_stock, :scope => "titles" )
    @submit = t(:new_stock, :scope => "buttons" )
  end

  def create
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_stock') || current_user.can?('create_all_stock')
    @stock = Stock.new(params[:stock])
    if @stock.save
      flash[:succes] = t(:new_stock_success, :scope => "flash")
      redirect_to stocks_path
      log("Created stock for #{@stock.material.name} in guild #{@stock.guild.name}")
    else
      render 'new'
    end
  end

  def edit
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_stock') || current_user.can?('edit_all_stock')
    @stock_item = Stock.find(params[:id])
    @submit = t(:edit_stock, :scope => "buttons" )
  end

  def update
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_stock') || current_user.can?('edit_all_stock')
    @stock_item = Stock.find(params[:id])
    deny_privileged_access and return unless current_user.guilds.includes( @stock_item.guild ) || current_user.can?('edit_all_stock')
    @stock_item.update_attributes(params[:stock])
    if params[:change]
      change = params[:change]
      @stock_item.amount = @stock_item.amount + change.to_i #negative change will substract
    end
    if @stock_item.save
      flash[:succes] = t(:update_stock_success, :scope => "flash")
    end
    redirect_to stocks_path
  end
end
