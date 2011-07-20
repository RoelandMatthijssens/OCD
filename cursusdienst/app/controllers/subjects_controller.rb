class SubjectsController < ApplicationController

  def index
    @title = "Subjects"
    @subjects = Subject.all
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
    @subject.disciplines= Discipline.all
    @submit = "Create new Subject"
  end

  def create
    @subject = Subject.new(params[:subject])
    @subject.disciplines= get_disciplines_from_subject(params[:subject])
    if @subject.save
      flash[:notice] = "Successfully created subject."
      redirect_to @subject
    else
      flash[:notice] = "NOT created subject. #{params[:subject]}"
      render :action => 'new'
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @submit = "Update Subject"
  end

  def update
    @subject = Subject.find(params[:id])
    if @subject.update_attributes(params[:subject])
      flash[:notice] = "Successfully updated subject."
      redirect_to @subject
    else
      render :action => 'edit'
    end
  end

  def destroy
  end

  private

  def get_disciplines_from_subject par
    ds = []
    par[:disciplines_attributes].each_value { |v|
      d = Discipline.find(v["id"])
      ds << d unless d.instance_of? Discipline
    }
    return ds
  end

end
