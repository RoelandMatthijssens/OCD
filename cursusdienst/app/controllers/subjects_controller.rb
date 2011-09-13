class SubjectsController < ApplicationController

  def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_subjects')
		@title = t(:all_subjects, :scope => "titles" )
    @subjects = Subject.paginate(:page => params[:page], :per_page => 10)
  end

  def show
		#deny_access and return unless signed_in?
		#deny_privileged_access and return unless current_user.can?('view_subjects')
    @subject = Subject.find(params[:id])
  end

  def new
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_subjects')
    @subject = Subject.new
    @dis_fac_inst = []
		@submit = t(:new_subject, :scope => "buttons" )
  end

  def create
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_subjects')
    @subject = Subject.new(params[:subject])
    @subject.disciplines= get_disciplines_from_subject(params[:subject])
    if @subject.save
			flash[:success] = t(:new_subject_success, :scope => "flash" )
      redirect_to @subject
    else
      @dis_fac_inst = get_dis_fac_inst_from_par(params[:subject])
			flash[:error] = t(:new_subject_fail, :scope => "flash", :subject => params[:subject])
      render :action => 'new'
    end
  end

  def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_subjects')
    @title = t(:edit_subject, :scope => "titles")
    @subject = Subject.find(params[:id])
    @dis_fac_inst = get_dis_fac_inst_from_subject(@subject)
		@submit = t(:update_subject, :scope => "buttons" )
  end

  def update
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_subjects')
    @subject = Subject.find(params[:id])
    @subject.disciplines= get_disciplines_from_subject(params[:subject])
    if @subject.update_attributes(params[:subject])
			flash[:notice] = t(:update_subject_success, :scope => "flash"  )
      redirect_to @subject
    else
      @dis_fac_inst = get_dis_fac_inst_from_par(params[:subject])
      render :action => 'edit'
    end
  end

  def destroy
  end

  private

  def get_disciplines_from_subject par
    ds = []
    par[:disciplines_attributes].each_value { |v|
      unless v["id"].empty?
        d = Discipline.find(v["id"])
        ds << d if d.instance_of? Discipline and v["_destroy"] != "1"
      end
    } unless par[:disciplines_attributes].nil?
    return ds
  end
  
  def get_dis_fac_inst_from_par par
    ds = []
    fac = []
    inst = []
    par[:disciplines_attributes].each_value { |v|
      if v["id"]
        ds << v["id"] 
        fac << v["faculty_id"]
        inst << v["institute_id"]
      end
    } unless par[:disciplines_attributes].nil?
    return [inst, fac, ds]
  end
  
  def get_dis_fac_inst_from_subject subject
    ds = []
    fac = []
    inst = []
    subject.disciplines.each{ |d|
      ds << d.id
      fac << d.faculty_id
      inst << d.institute_id
    }
    return [inst, fac, ds]
  end
end
