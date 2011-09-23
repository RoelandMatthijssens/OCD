class ResultsController < ApplicationController
  def index
    render 'per_guild'
  end

  def per_guild
    @title = t(:results_per_guild, :scope => "titles" )
    @guilds = Guild.all
    @results = {}
    @guilds.each do |guild|
      @results[guild] = MaterialOrder.joins(:order).find(:all, :conditions => ['status = ? and guild_id = ?', 'Ready', guild.id])
    end
  end
end
