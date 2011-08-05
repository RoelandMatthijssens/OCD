class PermissionGroupsController < ApplicationController
  def index
    @title = "Permission Groups"
    @permissions = PermissionGroup.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @permission = PermissionGroup.find(params[:id])
  end

  def new
    @permission = PermissionGroup.new
    @submit = "Create new Permission Group"
  end

  def create
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
    @permission = PermissionGroup.find(params[:id])
    @submit = "Update Permission Group"
  end

  def update
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
