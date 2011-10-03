class MessagesController < ApplicationController
  def index
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_all_messages')
    @messages = Message.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @message = Message.find(params[:id])
  end

  def new
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_message') || current_user.can?('create_all_messages')
    @message = Message.new
    @guild = params[:guild_id]
    @submit = t(:new_message, :scope => "buttons" )
  end

  def create
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_message') || current_user.can?('create_all_messages')
    @guild = Guild.find(params[:message][:guild_id])
    @message = Message.new(params[:message])
    @message.guild = @guild
    if @message.save
      log "New message posted #{@message.id}"
      flash[:succes] = t(:new_message_success, :scope => "flash" )
      redirect_to news_guild_path(@guild)
    else
      flash[:notice] = t(:new_message_fail, :scope => "flash" )
      render 'new'
    end
  end

  def edit
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_messages') || current_user.can?('edit_all_messages')
    @message = Message.find(params[:id])
    @submit = t(:update_message, :scope => "buttons" )
  end

  def update
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('edit_messages') || current_user.can?('edit_all_messages')
    @message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      flash[:succes] = t(:update_message_success, :scope => "flash" )
      redirect_to root_url(:subdomain => @message.guild.initials)
    else
      render 'edit'
    end
  end

  def destroy
  end
end
