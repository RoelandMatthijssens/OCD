class MaterialOrdersController < ApplicationController
  def show
    @title = "TODO"
    @material_order = MaterialOrder.find(params[:id])
  end

  def mark_as
  end
end
