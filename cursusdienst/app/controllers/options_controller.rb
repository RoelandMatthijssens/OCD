class OptionsController < ApplicationController
  def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_options')
    @title = "Options"
    @options = Option.paginate(:page => params[:page], :per_page => 10)
  end

  def show
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_options')
    @option = Option.find(params[:id])
  end

  def new
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_options')
    @option = Option.new
    @submit = "Create new Option"
  end

  def create
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_options')
    @option = Option.new(params[:option])
    if @option.save
      flash[:notice] = "Option succesfully created"
      redirect_to @option
    else
      flash[:notice] = "NOT created option. #{params[:option]}"
      render :action => 'new'
    end
  end

  def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_options')
    @option = Option.find(params[:id])
    @submit = "Update Option"
  end

  def update
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_options')
    @option = Option.find(params[:id])
    if @option.update_attributes(params[:option])
      flash[:notice] = "Option succesfully updated"
      redirect_to @option
    else
      render :action => 'edit'
    end
  end

  def destroy
  end

end
