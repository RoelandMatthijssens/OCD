class SubjectsController < ApplicationController

  def index
    @title = "Subjects"
    @subjects = Subject.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new
    @dis_fac_inst = []
    #@subject.disciplines << Discipline.find(:first) # if Discipline.count > 0
    @submit = "Create new Subject"
  end

  def create
    @subject = Subject.new(params[:subject])
    @subject.disciplines= get_disciplines_from_subject(params[:subject])
    if @subject.save
      flash[:notice] = "Subject succesfully created"
      redirect_to @subject
    else
      @dis_fac_inst = get_dis_fac_inst_from_subject(params[:subject])
      flash[:notice] = "NOT created subject. #{params[:subject]}"
      #flash[:notice] = "NOT created subject. #{get_disciplines_from_subject(params[:subject])}"
      render :action => 'new'
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @submit = "Update Subject"
  end

  def update
    @subject = Subject.find(params[:id])
    @subject.disciplines= get_disciplines_from_subject(params[:subject])
    if @subject.update_attributes(params[:subject])
      flash[:notice] = "Subject succesfully updated"
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
      ds << d if d.instance_of? Discipline and v["_destroy"] != "1"
    } unless par[:disciplines_attributes].nil?
    return ds
  end
  
  def get_dis_fac_inst_from_subject par
    ds = []
    fac = []
    inst = []
    par[:disciplines_attributes].each_value { |v|
      ds << v["id"] 
      fac << v["faculty_id"]
      inst << v["institute_id"]
    } unless par[:disciplines_attributes].nil?
    return [inst, fac, ds]
  end

end
