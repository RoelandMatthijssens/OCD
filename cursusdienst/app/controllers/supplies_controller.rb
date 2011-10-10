class SuppliesController < ApplicationController

  def new
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_supplies')
    @supply = Supply.new()
    previous_sold = Supply.find(:all, :conditions => ['material_id = ? and guild_id = ? ', params[:material], params[:guild]])
    if previous_sold && previous_sold.length == 1
      @supply = previous_sold.first
    end
    @material = Material.find(params[:material])
      @guilds = current_user.guilds
      @printers = Printer.all
      @price_sets = PriceSet.all
    @title = t(:add_to_supply, :scope => "title" )
    @submit = t(:add_to_supply, :scope => "buttons" )
  end

  def create
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_supplies')
    @supply = Supply.new(params[:supply])
    previous_sold = Supply.find(:all, :conditions => ['material_id = ? and guild_id = ? ', params[:supply][:material_id], params[:supply][:guild_id]])
    if previous_sold.length == 1
      @supply = previous_sold.first
      @supply.deleted = false
      update_existing params
    else
      create_new params
    end
  end


  def edit
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_supplies')
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
    deny_privileged_access and return unless current_user.can?('edit_supplies')
    @supply = Supply.find(params[:id])
    update_existing params
  end

  def destroy
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('delete_users')
    @supply = Supply.find(params[:id])
    @supply.deleted = true
    if @supply.save!
      flash[:succes] = t(:delete_supply_success, :scope => "flash" )
    else
      flash[:error] = t(:delete_supply_fail, :scope => "flash" )
    end
    redirect_to materials_path
  end

  private

  def update_existing params
    @supply.deleted = false
    if @supply.update_attributes(params[:supply])
      if params[:book_cost] && params[:book_cost][:book_cost]
        x = BookCost.new()
        x.amount = params[:book_cost][:book_cost].to_f
        x.supply = @supply
        x.save!
      end
      flash[:succes] = t(:update_supply_success, :scope => "flash")
      log("Edit supply #{@supply.id}")
      redirect_to materials_path
    else
      @title = t(:add_to_supply, :scope => "title" )
      @material = @supply.material
      @guilds = current_user.guilds
      @printers = Printer.all
      @price_sets = PriceSet.all
      @submit = t(:add_to_supply, :scope => "buttons" )
      lash[:succes] = t(:update_supply_fail, :scope => "flash")
      render 'edit'
    end
  end

  def create_new params
    if @supply.save
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
      #      redirect_to materials_path
      @title = t(:add_to_supply, :scope => "title" )
      @material = Material.find(params[:supply][:material_id])
      @guilds = current_user.guilds
      @printers = Printer.all
      @price_sets = PriceSet.all
      @submit = t(:add_to_supply, :scope => "buttons" )
      render 'new'
    end
  end

end
