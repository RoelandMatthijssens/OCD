class InstitutesController < ApplicationController
  
  def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_institutes')
    @title = t(:all_institutes, :scope => "titles")
    @institutes = Institute.paginate(:page => params[:page], :per_page => 10)
  end

  def show
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_institutes')
    @institute = Institute.find(params[:id])
  end
  
  def new
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_institutes')
    @institute = Institute.new
    @submit = t(:new_institute, :scope => "buttons")
  end
  
  def create
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_institutes')
    @institute = Institute.new(params[:institute])
    if @institute.save
      flash[:succes] = t(:new_institute_success, :scope => "flash")
      redirect_to @institute
    else
      render 'new'
    end
  end
  
  def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_institutes')
    @institute = Institute.find(params[:id])
    @submit = t(:update_institute, :scope => "buttons")
  end
  
  def update
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_institutes')
    @institute = Institute.find(params[:id])
    if @institute.update_attributes(params[:institute])
      flash[:succes] = t(:update_institute_success, :scope => "flash")
      redirect_to @institute
    else
      render 'edit'
    end
  end
  
  def destroy
  end

end
