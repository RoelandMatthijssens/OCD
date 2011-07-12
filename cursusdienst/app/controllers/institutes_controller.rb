class InstitutesController < ApplicationController
  
  def index
    @institutes = Institute.all
  end

  def show
    @institute = Institute.find(params[:id])
  end
  
  def new
    @institute = Institute.new
    @submit = "Create new Institution"
  end
  
  def create
    @institute = Institute.new(params[:institute])
    if @institute.save
      flash[:succes] = "Institution create succesfully"
      redirect_to @institute
    else
      render 'new'
    end
  end
  
  def edit
    @institute = Institute.find(params[:id])
    @submit = "Update Institution"
  end
  
  def update
    @institute = Institute.find(params[:id])
    if @institute.update_attributes(params[:institute])
      flash[:succes] = "Institute updated succesfully"
      redirect_to @institute
    else
      render 'edit'
    end
  end
  
  def destroy
  end

end
