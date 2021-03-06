class FacultiesController < ApplicationController

  def index
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_faculties')
    @title = "Faculties"
    @faculties = Faculty.active.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_faculties')
    @faculty = Faculty.find(params[:id])
  end

  def new
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_faculties')
    if params[:intitute_id]
      @faculty = Institute.find(params[:intitute_id]).new
    else
      @faculty = Faculty.new
    end
    @submit = t(:new_faculty, :scope => "buttons")
  end

  def create
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_faculties')
    @faculty = Faculty.new(params[:faculty])
    if @faculty.save
      flash[:succes] = t(:new_faculty_success, :scope => "flash")
      log "Created faculty: #{@faculty.name}"
      redirect_to @faculty
    else
      @selected_institute = get_id params[:faculty], :institute_id
      render 'new'
    end
  end

  def edit
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_faculties')
    @faculty = Faculty.find(params[:id])
    @selected_institute = @faculty.institute_id.to_s
    @submit = t(:update_faculty, :scope => "buttons")
  end

  def update
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_faculties')
    @faculty = Faculty.find(params[:id])
    if @faculty.update_attributes(params[:faculty])
      flash[:succes] = t(:update_faculty_success, :scope => "flash")
      log "Edit faculty: #{@faculty.name}"
      redirect_to @faculty
    else
      @selected_institute = get_id params[:faculty], :institute_id
      render 'edit'
    end
  end

  def destroy
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('delete_faculties')
    @faculty = Faculty.find(params[:id])
    @faculty.deleted = true
    if @faculty.save!
      flash[:succes] = t(:delete_faculty_success, :scope => "flash" )
    else
      flash[:error] = t(:delete_faculty_fail, :scope => "flash" )
    end
    redirect_to faculties_path
  end
end
