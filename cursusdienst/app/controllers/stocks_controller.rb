class StocksController < ApplicationController
	def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_stock') || current_user.can?('view_all_stock')
		@title = "Stock"
		@guilds = current_user.guilds
  end

	def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_stock') || current_user.can?('edit_all_stock')
		@stock_item = Stock.find(params[:id])
		@submit = "edit Stock"
		
	end

  def update
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_stock') || current_user.can?('edit_all_stock')
		@stock_item = Stock.find(params[:id])
		deny_privileged_access and return unless current_user.guilds.includes( @stock_item.guild ) || current_user.can?('edit_all_stock')
		@stock_item.update_attributes(params[:stock])
		redirect_to stocks_path
  end
end
