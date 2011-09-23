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
    @supply = Supply.new(params[:supply])
    if @supply.save
      @guild = Guild.find(params[:supply][:guild_id])
      @material = Material.find(params[:supply][:material_id])
      flash[:success] = t(:now_selling, :scope => "flash", :guild => @guild.name, :material => @material.name, :price => @price)
      redirect_to materials_path
    else
      flash[:error] = t(:selling_fail, :scope => "flash")
      redirect_to materials_path
    end
    #    end
  end
end
