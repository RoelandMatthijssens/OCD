class DisciplinesController < ApplicationController

   def index
     @title = "Disciplines"
    @disciplines = Discipline.all
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
      flash[:succes] = "Disciplines create succesfully"
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
