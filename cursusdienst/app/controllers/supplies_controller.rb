class SuppliesController < ApplicationController

  def new
    @supply = Supply.new()
    @title = t(:add_to_supply, :scope => "title" )
    @material = Material.find(params[:material])
    @guilds = current_user.guilds
    @printers = Printer.all
    @price_sets = PriceSet.all
    @submit = t(:add_to_supply, :scope => "buttons" )
  end

  def create
    @material = Material.find(params[:supply][:material])
    @guild = Guild.find(params[:supply][:guild])
    @price_set = PriceSet.find(params[:supply][:price_set])
    @price = params[:supply][:price]
    if @guild.materials.include?(@material)
      flash[:success] = t(:already_selling, :scope => "flash", :guild => @guild.name, :material => @material.name)
      redirect_to materials_path
    else
      @supply = Supply.new()
      @supply.price_set = @price_set
      @supply.material = @material
      @supply.price = @price
      @supply.guild = @guild
      if @supply.save
        flash[:success] = t(:now_selling, :scope => "flash", :guild => @guild.name, :material => @material.name, :price => @price)
        redirect_to materials_path
      else
        flash[:error] = t(:selling_fail, :scope => "flash", :guild => @guild.name, :material => @material.name)
        redirect_to materials_path
      end
    end
  end
end
