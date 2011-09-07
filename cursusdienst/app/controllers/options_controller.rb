class OptionsController < ApplicationController
  def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_options')
    @title = t(:all_options, :scope => "titles" )
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
    @submit = t(:new_option, :scope => "buttons" )
  end

  def create
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_options')
    @option = Option.new(params[:option])
    if @option.save
      flash[:notice] = t(:new_option_success, :scope => "flash" )
      redirect_to @option
    else
      flash[:notice] = t(:new_option_fail, :scope => "flash" )
      render :action => 'new'
    end
  end

  def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_options')
    @option = Option.find(params[:id])
    @submit = t(:update_option, :scope => "buttons" )
  end

  def update
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_options')
    @option = Option.find(params[:id])
    if @option.update_attributes(params[:option])
      flash[:notice] = t(:update_option_success, :scope => "flash" )
      redirect_to @option
    else
      render :action => 'edit'
    end
  end

  def destroy
  end

end
