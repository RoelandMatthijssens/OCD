class ResultsController < ApplicationController
  def index
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_results')
    per_guild
  end

  def per_guild
    @start_date ||= params[:start_date] ? Date.civil(params[:start_date].split('/')[2].to_i, params[:start_date].split('/')[0].to_i, params[:start_date].split('/')[0].to_i ) : 1.month.ago
    @end_date ||= params[:end_date] ? Date.civil(params[:end_date].split('/')[2].to_i, params[:end_date].split('/')[0].to_i, params[:end_date].split('/')[1].to_i ) : Time.now
    #{ material => [amountsoldbyself, totalsellpricebyself, totalbuypricebyself, amountsoldbyothers, totalsellpricebyothers, totalbuypricebyothers, revenue, profit] } #what each entry of the hash 'grouped_orders' looks like

    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_results')
    @title = t(:guild_results, :scope => "globals" )
    @guild ||= Guild.find_by_initials(request.subdomain)
    # get all the relevant material_orders to know who bought what where, and for how much. [material_id, guild_id, price, sell_price, amount]
    payed_orders = @guild.payed_orders(@start_date, @end_date)
    @grouped_orders = {}
    #loop over the orders
    payed_orders.each do |payed_order|
      #material encountered for the second time
      amount = payed_order.amount
      if @grouped_orders[payed_order.material]
        entry = @grouped_orders[payed_order.material]
        if payed_order.guild == @guild
          #sold by self
          entry[0] += amount
          entry[1] += payed_order.price
          entry[2] += payed_order.buy_price * amount
        else
          #sold by others
          entry[3] += amount
          entry[4] += payed_order.price
          entry[5] += payed_order.buy_price * amount
        end
      #material encountered for the first time
      else
        if payed_order.guild == @guild
          #sold by self
          @grouped_orders[payed_order.material] = [payed_order.amount, payed_order.price, payed_order.buy_price * amount, 0, 0, 0]
        else
          #sold by others
          @grouped_orders[payed_order.material] = [0, 0, 0, payed_order.amount, payed_order.price, payed_order.buy_price * amount]
        end
      end
    end
    @grouped_orders.each do |material, amounts|
      if material.owner
        #guild that is owner will receive 100% of own revenue, and 40% of the profit of others
        #this means the others will receive 60% of the profit of what they sell + the amount of costs to buy, when they are not the owner
        if material.owner == @guild
          revenue = amounts[1] + (40*(amounts[4]-amounts[5]))/100
        else
          revenue = amounts[2] + (60*(amounts[1]-amounts[2]))/100
        end
      else
        #guild that is calculating will receive all revenue that they have sold themselves, and none of that of other guilds
        revenue = amounts[1]
      end
      if material.owner
      #guild that is owner will receive 100% of own sold profit, and 40% of the profit of others
      #this means the others will receive 60% of the profit of what they sell, when they are not the owner
        if material.owner == @guild
          profit = (amounts[1]-amounts[2]) + (40*(amounts[4]-amounts[5]))/100
        else
          profit = (60*(amounts[1]-amounts[2]))/100
        end
      else
        #guild that is calculating will receive all profit that they have sold themselve, and none of that of other guilds
        profit = amounts[1]-amounts[2]
      end
      amounts << revenue
      amounts << profit
    end
    @grouped_orders = @grouped_orders.sort {|x, y| x[0].full_name <=> y[0].full_name}

    #@start_date = Date.civil(params[:range][:"start_date(1i)"].to_i,params[:range][:"start_date(2i)"].to_i,params[:range][:"start_date(3i)"].to_i)
    #@end_date = Date.civil(params[:range][:"end_date(1i)"].to_i,params[:range][:"end_date(2i)"].to_i,params[:range][:"end_date(3i)"].to_i)
  end

  def global
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_all_results')
    @guilds = Guild.active.all
    @start_date ||= params[:start_date] ? Date.civil(params[:start_date].split('/')[2].to_i, params[:start_date].split('/')[0].to_i, params[:start_date].split('/')[0].to_i ) : 1.month.ago
    @end_date ||= params[:end_date] ? Date.civil(params[:end_date].split('/')[2].to_i, params[:end_date].split('/')[0].to_i, params[:end_date].split('/')[1].to_i ) : Time.now
    @totals = []
    @global_profit=0
    @guilds.each do |guild|
      @guild = guild
      amountsoldbyself=0
      totalsellpricebyself=0
      totalbuypricebyself=0
      amountsoldbyothers=0
      totalsellpricebyothers=0
      totalbuypricebyothers=0
      totalrevenue=0
      totalprofit=0
      per_guild.each do |material, payed_order|
        amountsoldbyself+=payed_order[0]
        totalsellpricebyself+=payed_order[1]
        totalbuypricebyself+=payed_order[2]
        amountsoldbyothers+=payed_order[3]
        totalsellpricebyothers+=payed_order[4]
        totalbuypricebyothers+=payed_order[5]
        totalrevenue+=payed_order[6]
        totalprofit+=payed_order[7]
      end
      @totals << [guild, amountsoldbyself, totalsellpricebyself, totalbuypricebyself, amountsoldbyothers, totalsellpricebyothers, totalbuypricebyothers, totalrevenue, totalprofit]
      @global_profit+=totalprofit
    end
  end
end
