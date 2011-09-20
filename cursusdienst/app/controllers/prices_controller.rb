class PricesController < ApplicationController
  def index
    @title = t(:all_prices, :scope => "titles" )
    @prices = Price.all()
  end

  def new
    @title = t(:new_price, :scope => "titles" )
    @price = Price.new()
  end

  def create
    @price = Price.new(params[:price])
    @price_set = PriceSet.find(params[:price_set])
    @extra_option = ExtraOption.find(params[:extra_option])
    @price.extra_option = @extra_option
    @price_set.prices << @price
    if @price.save
      if @price_set.prices << @price
        flash[:success] = t(:new_price_success, :scope => "flash" )
        redirect_to @price
      else
        flash[:error] = t(:new_price_fail, :scope => "flash" )
        render :action => 'new'
      end
    else
      flash[:error] = t(:new_price_fail, :scope => "flash" )
      render :action => 'new'
    end
  end

  def show
    @price = Price.find(params[:id])
  end

  def edit
    @title = t(:edit_price, :scope => "titles" )
    @price = Price.find(params[:id])
    @submit = t(:update_price, :scope => "buttons" )
  end

  def update
    @price = Price.find(params[:id])
    if @price.update_attributes(params[:price])
      flash[:success] = t(:update_price_success, :scope => "flash" )
      redirect_to @price
    else
      redirect_to :action => 'edit'
    end
  end

  def destroy

  end
end
