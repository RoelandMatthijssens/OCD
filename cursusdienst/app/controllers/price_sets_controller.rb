class PriceSetsController < ApplicationController
  def index
    @title = t(:all_price_sets, :scope => "titles" )
    @price_sets = PriceSet.all
  end

  def new
    @title = t(:new_price_set, :scope => "titles" )
    @price_set = PriceSet.new()
  end

  def create
    @price_set = PriceSet.new(params[:price_set])
    @printer = Printer.find(params[:printer])
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
    @price_set = PriceSet.find(params[:id])
  end

  def edit
    @title = t(:edit_price_set, :scope => "titles" )
    @price_set = PriceSet.find(params[:id])
    @submit = t(:update_price_set, :scope => "buttons" )
  end

  def update
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
