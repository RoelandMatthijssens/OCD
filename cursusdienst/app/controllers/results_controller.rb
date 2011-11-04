class ResultsController < ApplicationController
  def index
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_results')
    per_guild
  end

  def per_guild
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_results')
    @title = t(:guild_results, :scope => "globals" )
    @guild = Guild.find_by_initials(request.subdomain)
    #material_orders = MaterialOrder.joins(:material).all #find(:all,
      #:conditions => ["material_orders.guild_id = ? OR 1", @guild.id])
    #material_orders = MaterialOrder.find(:all, :conditions => [''] guild.material_orders
    filter_status = ['Posted', 'Canceled']
    payed_orders = @guild.payed_orders
    @grouped_orders = {}
    payed_orders.each do |payed_order|
      if @grouped_orders[payed_order.material]
        @grouped_orders[payed_order.material] += payed_order.amount
      else
        @grouped_orders[payed_order.material] = payed_order.amount
      end
    end
    @grouped_orders = @grouped_orders.sort {|x, y| x[0].full_name <=> y[0].full_name}
    render 'per_guild'
  end

  def global
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_all_results')
    @guilds = Guild.all
    @grand_total = @guilds.first.grand_total
    @title = t(:general_results, :scope => "globals" )
  end
end
#select material_orders.id from material_orders, materials where materials.id = material_orders.material_id AND (materials.owner_id = 12 OR material_orders.guild_id = 12);
