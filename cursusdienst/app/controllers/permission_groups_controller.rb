class PermissionGroupsController < ApplicationController
  def index
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?("view_permission_groups")
    @title = t(:all_permission_groups, :scope => "titles" )
    @permission_groups = PermissionGroup.active.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?("view_permission_groups")
    @permission = PermissionGroup.find(params[:id])
  end

  def new
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?("create_permission_groups")
    @permission = PermissionGroup.new
    @submit = t(:new_permission_group, :scope => "buttons" )
  end

  def create
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?("create_permission_groups")
    @permission = PermissionGroup.new(params[:permission_group])
    if @permission.save
      flash[:notice] = t(:new_permission_group_success, :scope => "flash" )
      redirect_to @permission
    else
      flash[:notice] = t(:new_permission_group_fail, :scope => "flash" )
      render :action => 'new'
    end
  end

  def edit
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?("edit_permission_groups")
    @permission = PermissionGroup.find(params[:id])
    @submit = t(:upate_permission_group, :scope => "flash" )
  end

  def update
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?("edit_permission_groups")
    @permission = PermissionGroup.find(params[:id])
    if @permission.update_attributes(params[:permission_group])
      flash[:notice] = t(:update_permission_group, :scope => "flash" )
      redirect_to @permission
    else
      render :action => 'edit'
    end
  end

  def destroy
  end

end
