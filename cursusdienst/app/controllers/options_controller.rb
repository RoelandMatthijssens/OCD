class OptionsController < ApplicationController
  def index
    @title = "Options"
    @options = Option.paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @option = Option.find(params[:id])
  end

  def new
    @option = Option.new
    @submit = "Create new Option"
  end

  def create
    @option = Option.new(params[:option])
    if @option.save
      flash[:notice] = "Option succesfully created"
      redirect_to @option
    else
      flash[:notice] = "NOT created option. #{params[:option]}"
      #      flash[:notice] = "NOT created option. #{get_disciplines_from_option(params[:option])}"
      render :action => 'new'
    end
  end

  def edit
    @option = Option.find(params[:id])
    @submit = "Update Option"
  end

  def update
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
