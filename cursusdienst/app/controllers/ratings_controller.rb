class RatingsController < ApplicationController
  def index
    
  end
  
  def new
    
  end
  
  def create
    @rating = Rating.new(params[:rating])
    type = params[:rating][:rateable_type]
    id = params[:rating][:rateable_id]
    @rating.rateable_id = id
    @rating.rateable_type = type
    @rating.user_id = params[:rating][:user_id]
		#@info_string.content = params[:content]
		#@info_string.key = params[:key]
		if @rating.save
			flash[:success] = "blablabla COOOOOL"
    else
      flash[:error] = "BLABLALBA Sad :("
    end
    redirect_to (type.camelize.constantize).find(id)
	end
  
  def show
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
end
