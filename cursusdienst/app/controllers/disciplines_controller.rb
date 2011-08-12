class DisciplinesController < ApplicationController

   def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("view_disciplines")
		@title = "Disciplines"
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
    @discipline = Discipline.new
    @faculties = get_data_from_filter params[:discipline], :faculty_id, Faculty
    @submit = "Create new Discipline"
  end

  def create
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("create_disciplines")
    @discipline = Discipline.new(params[:discipline])
    if @discipline.save
      flash[:succes] = "Discipline created succesfully"
      redirect_to @discipline
    else
      @faculties = get_data_from_filter params[:discipline], :faculty_id, Faculty
      render 'new'
    end
  end

  def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("edit_disciplines")
    @discipline = Discipline.find(params[:id])
    @faculties = get_data_from_material @discipline, :faculty_id
    @submit = "Update Discipline"
  end

  def update
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("edit_disciplines")
    @discipline = Discipline.find(params[:id])
    if @discipline.update_attributes(params[:discipline])
      flash[:succes] = "Discipline updated succesfully"
      redirect_to @discipline
    else
      @faculties = get_data_from_material @discipline, :faculty_id
      render 'edit'
    end
  end

  def destroy
  end

end
