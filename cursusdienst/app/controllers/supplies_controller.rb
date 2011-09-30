class SuppliesController < ApplicationController

  def new
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_supplies')
    @supply = Supply.new()
    @title = t(:add_to_supply, :scope => "title" )
    @material = Material.find(params[:material])
    @guilds = current_user.guilds
    @printers = Printer.all
    @price_sets = PriceSet.all
    @submit = t(:add_to_supply, :scope => "buttons" )
  end

  def create
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_supplies')
    @supply = Supply.new(params[:supply])
    if @supply.save!
      if params[:book_cost] && params[:book_cost][:book_cost]
        x = BookCost.new()
        x.amount = params[:book_cost][:book_cost].to_f
        x.supply = @supply
        x.save!
      end
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


  def edit
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_institutes')
    @supply = Supply.find(params[:id])
    @title = t(:add_to_supply, :scope => "title" )
    @material = @supply.material
    @guilds = current_user.guilds
    @printers = Printer.all
    @price_sets = PriceSet.all
    @price_set = @supply.price_set
    @printer = @price_set.printer
    @submit = t(:update_supply, :scope => "buttons")
  end

  def update
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_institutes')
    @supply = Supply.find(params[:id])
    if @supply.update_attributes(params[:supply])
      if params[:book_cost][:book_cost]
        x = BookCost.new()
        x.amount = params[:book_cost][:book_cost].to_f
        x.supply = @supply
        x.save!
      end
      flash[:succes] = t(:update_supply_success, :scope => "flash")
      log("Edit supply #{@supply.id}")
      redirect_to root_url(:subdomain => @supply.guild.initials)
    else
      render 'edit'
    end
  end
end
