class FacultiesController < ApplicationController

  def index
    @title = "Faculties"
    @faculties = Faculty.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @faculty = Faculty.find(params[:id])
  end

  def new
    @faculty = Faculty.new
    @submit = "Create new Faculty"
  end

  def create
    @faculty = Faculty.new(params[:faculty])
    if @faculty.save
      flash[:succes] = "Faculty created succesfully"
      redirect_to @faculty
    else
      render 'new'
    end
  end

  def edit
    @faculty = Faculty.find(params[:id])
    @submit = "Update Faculty"
  end

  def update
    @faculty = Faculty.find(params[:id])
    if @faculty.update_attributes(params[:faculty])
      flash[:succes] = "Faculty updated succesfully"
      redirect_to @faculty
    else
      render 'edit'
    end
  end

  def destroy
  end

end
