class UsersController < ApplicationController
  def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_users')
		@title = "Users"
		@users = User.paginate(:page => params[:page], :per_page => 10)
  end

  def show
		@user = User.find(params[:id])
		if signed_in?
			deny_privileged_access unless current_user == @user || current_user.can?("view_users")
		else
			deny_access
		end
  end

  def new
    @user = User.new
    @submit = t(:register, :scope => 'user.signup')
  end

  def create
#    TODO Add user to guild on signup
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:succes] = "Registration succesfull"
      if @user.guilds.emty?
        redirect_to @user
      else
        redirect_to @user.guilds.first
      end
    else
      render 'new'
    end
  end

  def edit
		@user = User.find(params[:id])
		if signed_in?
			deny_privileged_access unless current_user == @user || current_user.can?('edit_users')
		else
			deny_access
		end
  end

  def update
    @user = User.find(params[:id])
    if signed_in?
			deny_privileged_access unless current_user == @user || current_user.can?("edit_users")
			if @user.update_attributes(params[:user])
				flash[:succes] = "User updated succesfully"
				redirect_to @user
			else
				render 'edit'
			end
		else
			deny_access
    end
  end

  def destroy
  end

  def edit_permissions
		@user = User.find(params[:id])
		@user = User.find(params[:id])
		if signed_in?
			deny_privileged_access unless current_user.can?("edit_permissions")
		@submit = "Save permissions"
		else
			deny_access
		end
  end

  def update_permissions
		@user = User.find(params[:id])
		selected_ids = params[:permission_ids]
		unselected_ids = []
		@permissions = @user.permission_groups
		@permissions.each { |x| unselected_ids << x unless selected_ids.include?(x.id.to_s)}

		if selected_ids.include?("-1")
			@user.permission_groups = []
		elsif selected_ids.include?(0.to_s)
			@user.permission_groups << PermissionGroup.all
		else
			selected_ids && selected_ids.each do |permission_id|
				p = PermissionGroup.find(permission_id)
				@user.permission_groups << p unless @permissions.include? p
			end
			unselected_ids.each do |permission|
				@user.permission_groups.delete(permission)
			end
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
