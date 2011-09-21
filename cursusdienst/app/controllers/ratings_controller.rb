class RatingsController < ApplicationController
  def index
    
  end
  
  def new
    
  end
  
  def create
    @rating = Rating.new(params[:rating])
    @rating.rateable_id = params[:rating][:rateable_id]
    @rating.rateable_type = params[:rating][:rateable_type]
    @rating.user_id = params[:rating][:user_id]
		#@info_string.content = params[:content]
		#@info_string.key = params[:key]
		if @rating.save
			flash[:succes] = t(:new_info_string_success, :scope => "flash" )
    else
      flash[:error] = t(:new_info_string_fail, :scope => "flash" )
      render root_url
    end
    redirect_to root_url
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
