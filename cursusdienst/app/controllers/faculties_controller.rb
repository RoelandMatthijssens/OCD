class FacultiesController < ApplicationController

  def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_faculties')
    @title = "Faculties"
    @faculties = Faculty.paginate(:page => params[:page], :per_page => 10)
  end

  def show
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_faculties')
    @faculty = Faculty.find(params[:id])
  end

  def new
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_faculties')
    @faculty = Faculty.new
    @submit = "Create new Faculty"
  end

  def create
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_faculties')
    @faculty = Faculty.new(params[:faculty])
    if @faculty.save
      flash[:succes] = "Faculty created succesfully"
      redirect_to @faculty
    else
      render 'new'
    end
  end

  def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_faculties')
    @faculty = Faculty.find(params[:id])
    @submit = "Update Faculty"
  end

  def update
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_faculties')
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
