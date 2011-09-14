class InfoStringsController < ApplicationController
	
	def index
		@title = t(:all_info_strings, :scope => "titles" )
	end
	
	def new
		@info_string = InfoString.new()
		@key = params[:key]
		@guild = params[:guild_id]
	end
	
	def create
		@guild = Guild.find(params[:info_string][:guild_id])
		@info_string = InfoString.new(params[:info_string])
		#@info_string.content = params[:content]
		@info_string.guild = @guild
		#@info_string.key = params[:key]
		if @info_string.save
			flash[:succes] = t(:new_info_string_success, :scope => "flash" )
    else
      flash[:error] = t(:new_info_string_fail, :scope => "flash" )
      render 'new'
    end
    redirect_to info_strings_path
	end
	
	def show
		@info_string = InfoString.find(params[:id])
	end
	
	def edit
		@info_string = InfoString.find(params[:id])
	end
	
	def update
		@info_string = InfoString.find(params[:id])
		if @info_string.update_attributes(params[:info_string])
			flash[:succes] = t(:update_info_string_success, :scope => "flash" )
			redirect_to @info_string
		else
			render 'edit'
		end
	end
	
	def destroy
	
	end
	
end
