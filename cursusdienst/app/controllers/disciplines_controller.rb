class DisciplinesController < ApplicationController

   def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("view_disciplines")
		@title = "Disciplines"
		@disciplines = Discipline.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @discipline = Discipline.find(params[:id])
  end

  def new
    @discipline = Discipline.new
    @submit = "Create new Discipline"
  end

  def create
    @discipline = Discipline.new(params[:discipline])
    if @discipline.save
      flash[:succes] = "Discipline created succesfully"
      redirect_to @discipline
    else
      render 'new'
    end
  end

  def edit
    @discipline = Discipline.find(params[:id])
    @submit = "Update Discipline"
  end

  def update
    @discipline = Discipline.find(params[:id])
    if @discipline.update_attributes(params[:discipline])
      flash[:succes] = "Discipline updated succesfully"
      redirect_to @discipline
    else
      render 'edit'
    end
  end

  def destroy
  end

end
