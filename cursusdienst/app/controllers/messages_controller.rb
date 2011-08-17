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
    @submit = "Create new Message"
  end

  def create
		@guild = Guild.find(params[:message][:guild_id])
		@message = Message.new(params[:message])
		@message.guild = @guild
    if @message.save
      flash[:succes] = "Message succesfully created"
      redirect_to @guild
    else
			flash[:notice] = "NOT created message. #{params[:subject]}"
      render 'new'
    end
  end

  def edit
		@message = Message.find(params[:id])
    @submit = "Update Message"
  end

  def update
		@message = Message.find(params[:id])
    if @message.update_attributes(params[:message])
      flash[:succes] = "Message updated succesfully"
      redirect_to @message
    else
      render 'edit'
    end
  end

  #def mark_

  def destroy
  end
end
