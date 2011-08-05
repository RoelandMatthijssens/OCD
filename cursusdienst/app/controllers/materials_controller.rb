class MaterialsController < ApplicationController

  def index
    @title = "Materials"
    @materials = Material.paginate(:page => params[:page], :per_page => 10)
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
    @material.options= get_options_from_material(params[:material])
    if @material.save
      flash[:succes] = "Material succesfully created"
      redirect_to @material
    else
			flash[:notice] = "NOT created subject. #{params[:subject]}"
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
    @material.options = get_options_from_material(params[:material])
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
  
  def get_options_from_material par
    os = []
    par[:options_attributes].each_value { |v|
      o = Option.find(v["id"])
      os << o if o.instance_of? Option and v["_destroy"] != "1"
    } unless par[:options_attributes].nil?
    return os
  end
  
end
