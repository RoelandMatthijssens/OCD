class UsersController < ApplicationController
  def index
		deny_access unless signed_in?
    @title = "Users"
    @users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @submit = "Register"
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:succes] = "Registration succesfull"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if current_user && (current_user == @user || current_user.can("edit_users"))
			#user can edit the selected user
			if @user.update_attributes(params[:user])
				flash[:succes] = "User updated succesfully"
				redirect_to @user
			else
				render 'edit'
			end
		else
			#user can't edit the selected user
			flash[:error] = "You are not allowed to edit this user"
			redirect_to idiot_path
    end
  end

  def destroy
  end

  def edit_permissions
		@user = User.find(params[:id])
		@submit = "Save permissions"
  end
  
  def update_permissions
		@user = User.find(params[:id])
		selected_ids = params[:permission_ids]
		unselected_ids = []
		@permissions = @user.permission_groups
		@permissions.each { |x| unselected_ids << x unless selected_ids.include?(x.id.to_s)}
		
		selected_ids && selected_ids.each do |permission_id|
			p = PermissionGroup.find(permission_id)
			@user.permission_groups << p unless @permissions.include? p
		end
		unselected_ids.each do |permission|
			@user.permission_groups.delete(permission)
		end
		flash[:succes] = "Permissions updated"
		redirect_to edit_permissions_user_path
  end

 private
 
	def authenticate
		deny_access unless signed_in?
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to(root_path) unless current_user?(@user)
	end

end
