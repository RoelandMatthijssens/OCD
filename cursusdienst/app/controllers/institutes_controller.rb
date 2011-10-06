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
      log("Created institute #{@institute.name}")
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
      log("Edit institute #{@institute.name}")
      redirect_to @institute
    else
      render 'edit'
    end
  end

  def destroy
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('delete_institutes')
    @institute = Institute.find(params[:id])
    @institute.deleted = true
    if @institute.save!
      flash[:succes] = t(:delete_institute_success, :scope => "flash" )
    else
      flash[:error] = t(:delete_institute_fail, :scope => "flash" )
    end
    redirect_to institutes_path
  end

end
