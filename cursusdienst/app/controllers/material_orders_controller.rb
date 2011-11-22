class MaterialOrdersController < ApplicationController
  def show
    @title = "TODO"
    @material_order = MaterialOrder.find(params[:id])
  end

  def mark_as
  end

  def fill_buy_price
    material_orders = MaterialOrder.all
    @res = []
    material_orders.each do |x|
      if x.buy_price
        @res << "#{x.id} already has buy_price"
      else
        g = x.guild
        i = x.material
        a = x.amount
        supply = Supply.find(:first, :conditions => ["guild_id = ? and material_id = ?", g.id, i.id])
        if supply
          x.buy_price = supply.buy_price
          x.save!
          @res << "#{x.id} buy_price set to #{x.buy_price}"
        end
      end
    end
  end
end
