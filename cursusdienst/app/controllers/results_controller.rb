class ResultsController < ApplicationController
  def index
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_results')
    per_guild
  end

  def per_guild
    @start_date ||= params[:start_date] ? Date.civil(params[:start_date].split('/')[2].to_i, params[:start_date].split('/')[0].to_i, params[:start_date].split('/')[0].to_i ) : 1.month.ago
    @end_date ||= params[:end_date] ? Date.civil(params[:end_date].split('/')[2].to_i, params[:end_date].split('/')[0].to_i, params[:end_date].split('/')[1].to_i ) : Time.now
    #{ material => [amountsoldbyself, totalsellpricebyself, totalbuypricebyself, amountsoldbyothers, totalsellpricebyothers, totalbuypricebyothers] } #what each entry of the hash 'grouped_orders' looks like

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
    @res = []
    @guilds.each do |guild|
      @guild = guild
      amountsoldbyself=0
      totalsellpricebyself=0
      totalbuypricebyself=0
      amountsoldbyothers=0
      totalsellpricebyothers=0
      totalbuypricebyothers=0
      per_guild.each do |material, payed_order|
        amountsoldbyself+=payed_order[0]
        totalsellpricebyself+=payed_order[1]
        totalbuypricebyself+=payed_order[2]
        amountsoldbyothers+=payed_order[3]
        totalsellpricebyothers+=payed_order[4]
        totalbuypricebyothers+=payed_order[5]
      end
      @res << [guild.initials, amountsoldbyself, totalsellpricebyself, totalbuypricebyself, amountsoldbyothers, totalsellpricebyothers, totalbuypricebyothers]
    end
  end
end
