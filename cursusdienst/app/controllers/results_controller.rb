class ResultsController < ApplicationController
  def index
    @guilds = Guild.all
    @title = t(:general_results, :scope => "globals" )
  end

  def per_guild
    @title = t(:guild_results, :scope => "globals" )
    @guild = Guild.find_by_initials(request.subdomain)
    material_orders = @guild.material_orders
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
end
