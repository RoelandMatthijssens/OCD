class MessagesController < ApplicationController
	def index
		@messages = Message.paginate(:page => params[:page], :per_page => 10)
  end

  def show
		@message = Message.find(params[:id])
  end

  def new
		@message = Message.new
		@guild = params[:guild_id]
    @submit = t(:new_message, :scope => "buttons" )
  end

  def create
		@guild = Guild.find(params[:message][:guild_id])
		@message = Message.new(params[:message])
		@message.guild = @guild
    if @message.save
      flash[:succes] = t(:new_message_success, :scope => "flash" )
      redirect_to @guild
    else
			flash[:notice] = t(:new_message_fail, :scope => "flash" )
      render 'new'
    end
  end

  def edit
		@message = Message.find(params[:id])
    @submit = t(:update_message_success, :scope => "buttons" )
  end

  def update
		@message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      flash[:succes] = t(:update_message_success, :scope => "flash" )
      redirect_to @message.guild
    else
      render 'edit'
    end
  end

  def destroy
  end
end
