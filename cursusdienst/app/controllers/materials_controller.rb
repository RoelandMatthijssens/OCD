class MaterialsController < ApplicationController
  def index
    @title = "Materials"
    @materials = Material.all
  end

  def show
    @material = Material.find(params[:id])
  end

  def new
    @material = Material.new
    @submit = "Create new Material"
  end

  def create
    @material = Material.new(params[:material])
    if @material.save
      flash[:succes] = "Material succesfully created"
      redirect_to @material
    else
      render 'new'
    end
  end

  def edit
    @material = Material.find(params[:id])
    @submit = "Update Material"
  end

  def update
    @material = Material.find(params[:id])
    @material.subject = nil unless subject_given?(params[:material])
    if @material.update_attributes(params[:material])
      flash[:succes] = "Material updated succesfully"
      redirect_to @material
    else
      render 'edit'
    end
  end

  def destroy
  end
  
  private
  
  def subject_given? par
    return par[:subject_id]
  end
  
end
