class DisciplinesController < ApplicationController

  def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("view_disciplines")
		@title = t(:all_disciplines, :scope => "titles")
		@disciplines = Discipline.paginate(:page => params[:page], :per_page => 10)
  end

  def show
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("view_disciplines")
    @discipline = Discipline.find(params[:id])
  end

  def new
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("create_disciplines")
    if params[:faculty_id]
      @discipline = Faculty.find(params[:faculty_id]).disciplines.new
    else
      @discipline = Discipline.new
    end
    @discipline = Discipline.new
    @faculties = get_data_from_filter params[:discipline], :faculty_id, Faculty
    @selected_institute = ""
    @selected_faculty = ""
    @submit = t(:new_discipline, :scope => "buttons")
  end

  def create
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("create_disciplines")
    @discipline = Discipline.new(params[:discipline])
    if @discipline.save
      flash[:succes] = t(:new_discipline_success, :scope => "flash")
      redirect_to @discipline
    else
      @faculties = get_data_from_filter params[:discipline], :faculty_id, Faculty
      @selected_institute = get_id params[:discipline], :institute_id 
      @selected_faculty = get_id params[:discipline], :faculty_id
      render 'new'
    end
  end

  def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("edit_disciplines")
    @discipline = Discipline.find(params[:id])
    @faculties = get_data_from_material @discipline, :faculty_id
    @selected_institute = @discipline.faculty.institute.id.to_s
    @selected_faculty = @discipline.faculty_id.to_s
    @submit = t(:update_discipline, :scope => "buttons")
  end

  def update
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("edit_disciplines")
    @discipline = Discipline.find(params[:id])
    if @discipline.update_attributes(params[:discipline])
      flash[:succes] = t(:update_discipline_success, :scope => "flash")
      redirect_to @discipline
    else
      @faculties = get_data_from_material @discipline, :faculty_id
      @selected_institute = get_id params[:discipline], :institute_id 
      @selected_faculty = get_id params[:discipline], :faculty_id
      render 'edit'
    end
  end

  def destroy
  end
  
end
