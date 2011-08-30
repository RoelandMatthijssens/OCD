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
			if shopping_cart_item.save
				flash[:message] = "item amount increased"
			else
				flash[:error] = "something went horribly wrong"
			end
		else
			flash[:error] = "item not found, wrong id given"
		end
		redirect_to shopping_cart_items_path
  end

  def substract
		shopping_cart_item = ShoppingCartItem.find(params[:id])
		if shopping_cart_item
			if shopping_cart_item.amount > 0
				shopping_cart_item.amount -= 1
				if shopping_cart_item.save
					flash[:message] = "item amount decreased"
				else
					flash[:error] = "something went horribly wrong"
				end
			else
				flash[:error] = "item not in cart"
			end
		else
			flash[:error] = "item not found, wrong id given"
		end
		if shopping_cart_item.amount == 0
			shopping_cart_item.delete
		end
		redirect_to shopping_cart_items_path
  end
end
