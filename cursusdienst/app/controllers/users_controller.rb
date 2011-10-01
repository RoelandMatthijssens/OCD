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
    if params[:user][:user_name]
      @user.email = "#{params[:user][:user_name]}@vub.ac.be"
    end
    guild_id = params[:guild]
    unless guild_id.empty?
      @guild = Guild.find(guild_id)
    end
    if ! guild_id.empty? && @user.save
      sign_in @user
      @guild.users << @user if @guild
      flash[:succes] = t(:new_user_success, :scope => "flash" )
      flash[:error] = guild_id ? "True" : "False"
      if @user.guilds.empty?
        redirect_to @user
      else
        redirect_to root_url(:subdomain => @user.guilds.first.initials)
      end
    elsif guild_id.empty?
      flash[:error] = t(:new_user_no_guild_fail, :scope => "flash" )
      render 'new'
    else
      flash[:error] = t(:new_user_fail, :scope => "flash" )
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
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('delete_users')
    @user = User.find(params[:id])
    @user.deleted = true
    if @user.save!
      flash[:succes] = t(:delete_user_success, :scope => "flash" )
    else
      flash[:error] = t(:delete_user_fail, :scope => "flash" )
    end
    redirect_to users_path
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
  
  def tyca 
    return []
  end
  def senior 
    return ["use_control_panel","sell_materials","sell_all_materials","create_all_messages","view_all_stock","view_all_orders","print","download_materials","edit_users","view_users","delete_users","view_permissions","edit_disciplines","delete_disciplines","view_disciplines","create_disciplines","edit_subjects","delete_subjects","view_subjects","create_subjects","view_institutes","edit_guilds","delete_guilds","view_guilds","create_guilds","edit_materials","delete_materials","view_materials","create_materials","edit_faculties","delete_faculties","view_faculties","create_faculties","edit_messages","delete_messages","create_messages","edit_stock","delete_stock","view_stock","edit_printers","delete_printers","view_printers","create_printers","edit_prices","delete_prices","view_prices","create_prices","edit_price_sets","delete_price_sets","view_price_sets","create_price_sets","edit_attachments","delete_attachments","view_attachments","create_attachments","edit_info_strings","delete_info_strings","view_info_strings","create_info_strings","edit_orders","delete_orders","view_orders","create_orders","edit_print_jobs","delete_print_jobs","view_print_jobs","create_print_jobs","edit_ratings","delete_ratings","view_ratings","create_ratings","edit_supplies","delete_supplies","create_supplies","view_supplies","set_order_status","view_side_supply","view_all_guilds","join_guilds","view_permission_groups","edit_options","delete_options","view_options","create_options"]
  end
  def junior 
    return ["use_control_panel","sell_materials","sell_all_materials","print","download_materials","edit_users","view_users","delete_users","edit_disciplines","delete_disciplines","view_disciplines","create_disciplines","edit_subjects","delete_subjects","view_subjects","create_subjects","view_institutes","edit_guilds","delete_guilds","view_guilds","edit_materials","delete_materials","view_materials","create_materials","view_faculties","edit_messages","delete_messages","create_messages","edit_stock","delete_stock","view_stock","view_printers","edit_prices","delete_prices","view_prices","create_prices","edit_price_sets","delete_price_sets","view_price_sets","edit_attachments","delete_attachments","view_attachments","create_attachments","edit_info_strings","delete_info_strings","view_info_strings","create_info_strings","edit_orders","delete_orders","view_orders","create_orders","view_print_jobs","edit_ratings","delete_ratings","view_ratings","create_ratings","edit_supplies","delete_supplies","create_supplies","view_supplies","set_order_status","view_side_supply","join_guilds",]
  end
  def user 
    return []
  end

end
