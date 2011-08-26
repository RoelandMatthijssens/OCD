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
end
