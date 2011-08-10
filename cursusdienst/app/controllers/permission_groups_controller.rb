class PermissionGroupsController < ApplicationController
  def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("view_permission_groups")
    @title = "Permission Groups"
    @permission_groups = PermissionGroup.paginate(:page => params[:page], :per_page => 10)
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
    @submit = "Create new Permission Group"
  end

  def create
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("create_permission_groups")
    @permission = PermissionGroup.new(params[:permission_group])
    if @permission.save
      flash[:notice] = "Permission Group succesfully created"
      redirect_to @permission
    else
      flash[:notice] = "NOT created permission. #{params[:permission_group]}"
      render :action => 'new'
    end
  end

  def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("edit_permission_groups")
    @permission = PermissionGroup.find(params[:id])
    @submit = "Update Permission Group"
  end

  def update
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?("edit_permission_groups")
    @permission = PermissionGroup.find(params[:id])
    if @permission.update_attributes(params[:permission_group])
      flash[:notice] = "Permission Group succesfully updated"
      redirect_to @permission
    else
      render :action => 'edit'
    end
  end

  def destroy
  end

end
