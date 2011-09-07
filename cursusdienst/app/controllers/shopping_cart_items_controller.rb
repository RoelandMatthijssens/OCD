class ShoppingCartItemsController < ApplicationController
	def index
		deny_access and return unless signed_in?
		@shopping_cart_items = current_user.shopping_cart_items
  end

  def show
		deny_access and return unless signed_in?
		@shopping_cart_items = current_user.shopping_cart_items
  end
  
  def edit
  end

  def update
  end

  def destroy
  end

  def add
		shopping_cart_item = ShoppingCartItem.find(params[:id])
		if shopping_cart_item
			shopping_cart_item.amount += 1
			flash[:error] = t(:shopping_cart_amount_change_fail, :scope => "flash" ) unless shopping_cart_item.save!
		else
			flash[:error] = t(:shopping_cart_item_not_found, :scope => "flash" )
		end
		redirect_to shopping_cart_items_path
  end

  def substract
		shopping_cart_item = ShoppingCartItem.find(params[:id])
		if shopping_cart_item
			if shopping_cart_item.amount > 0
				shopping_cart_item.amount -= 1
				flash[:error] = t(:shopping_cart_amount_change_fail, :scope => "flash" ) unless shopping_cart_item.save!
			else
				flash[:error] = t(:shopping_cart_item_not_found, :scope => "flash" )
			end
		else
			flash[:error] = t(:shopping_cart_item_not_found, :scope => "flash" )
		end
		if shopping_cart_item.amount == 0
			shopping_cart_item.delete
		end
		redirect_to shopping_cart_items_path
  end
end
