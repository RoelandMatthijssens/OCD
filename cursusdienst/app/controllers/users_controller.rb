class UsersController < ApplicationController
  def index
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_users')
    @title = t(:all_users, :scope => "titles" )
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
    @user = User.new(params[:user])
    guild_id = params[:guild]
    unless guild_id.nil?
      @guild = Guild.find(guild_id)
    end
    if @user.save
      sign_in @user
      @guild.users << @user if @guild
      flash[:succes] = t(:new_user_success, :scope => "flash" )
      flash[:error] = guild_id ? "True" : "False"
      if @user.guilds.empty?
        redirect_to @user
      else
        redirect_to root_url(:subdomain => @user.guilds.first.initials)
      end
    else
      flash[:succes] = t(:new_user_fail, :scope => "flash" )
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
        flash[:succes] = t(:update_user_success, :scope => "flash" )
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
    @submit = t(:update_user_permissions, :scope => "buttons" )
    else
      deny_access
    end
  end

  def update_permissions
    tyca = []
    senior = ["create_all_messages"]
    junior = ["create_messages"]
    user = []
    tyca_profile = []; senior_profile = []; junior_profile = []; user_profile = []
    [[tyca, tyca_profile], [senior, senior_profile], [junior, junior_profile], [user, user_profile]].each do |profile, result_list|
      profile.each do |permission_name|
        permission = PermissionGroup.find_by_name(permission_name)
        result_list << permission
      end
    end
    @user = User.find(params[:id])
    selected_ids = params[:permission_ids]
    unselected_ids = []
    @permissions = @user.permission_groups
    @permissions.each { |x| unselected_ids << x unless selected_ids.include?(x.id.to_s)}

    if selected_ids.include?("-1")
      @user.permission_groups = []
    elsif selected_ids.include?(0.to_s)
      @user.permission_groups = PermissionGroup.all
    elsif selected_ids.include?("-2")
      @user.permission_groups = senior_profile
    elsif selected_ids.include?("-3")
      @user.permission_groups = junior_profile
    elsif selected_ids.include?("-4")
      @user.permission_groups = user_profile
    else
      selected_ids && selected_ids.each do |permission_id|
        p = PermissionGroup.find(permission_id)
        @user.permission_groups << p unless @permissions.include? p
      end
      unselected_ids.each do |permission|
        @user.permission_groups.delete(permission)
      end
    end
    flash[:succes] = t(:update_user_permissions_success, :scope => "flash", :user => @user.name )
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
