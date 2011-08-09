class SubjectsController < ApplicationController

  def index
		if signed_in?
			deny_privileged_access unless current_user.can?('view_subjects')
			@title = "Subjects"
			@subjects = Subject.paginate(:page => params[:page], :per_page => 10)
		else
			deny_access
		end
  end

  def show
    if signed_in?
			deny_privileged_access unless current_user.can?('view_subjects')
			@subject = Subject.find(params[:id])
		else
			deny_access
		end
  end

  def new
    if signed_in?
			deny_privileged_access unless current_user.can?('create_subjects')
			@subject = Subject.new
			@submit = "Create new Subject"
		else
			deny_access
		end
  end

  def create
    if signed_in?
			deny_privileged_access unless current_user.can?('create_subjects')
			@subject = Subject.new(params[:subject])
			@subject.disciplines= get_disciplines_from_subject(params[:subject])
			if @subject.save
				flash[:notice] = "Subject succesfully created"
				redirect_to @subject
			else
				flash[:notice] = "NOT created subject. #{params[:subject]}"
				render 'new'
			end
		else
			deny_access
		end
  end

  def edit
    if signed_in?
			deny_privileged_access unless current_user.can?('edit_subjects')
			@subject = Subject.find(params[:id])
			@submit = "Update Subject"
		else
			deny_access
		end
  end

  def update
    if signed_in?
			deny_privileged_access unless current_user.can?('create_subjects')
			@subject = Subject.find(params[:id])
			@subject.disciplines = get_disciplines_from_subject(params[:subject])
			if @subject.update_attributes(params[:subject])
				flash[:notice] = "Subject succesfully updated"
				redirect_to @subject
			else
				render :action => 'edit'
			end
		else
			deny_access
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

end
