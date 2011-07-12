class FacultiesController < ApplicationController

  def index
    @faculties = faculty.all
  end

  def show
    @faculty = faculty.find(params[:id])
  end

  def new
    @faculty = faculty.new
    @submit = "Create new Institution"
  end

  def create
    @faculty = faculty.new(params[:faculty])
    if @faculty.save
      flash[:succes] = "Institution create succesfully"
      redirect_to @faculty
    else
      render 'new'
    end
  end

  def edit
    @faculty = faculty.find(params[:id])
    @submit = "Update Institution"
  end

  def update
    @faculty = faculty.find(params[:id])
    if @faculty.update_attributes(params[:faculty])
      flash[:succes] = "faculty updated succesfully"
      redirect_to @faculty
    else
      render 'edit'
    end
  end

  def destroy
  end

end
