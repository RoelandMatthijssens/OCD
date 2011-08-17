class GuildsController < ApplicationController
  def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_guilds')
    @title = "Guilds"
    @guilds = Guild.paginate(:page => params[:page], :per_page => 10)
  end

  def show
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_guilds')
    @guild = Guild.find(params[:id])
  end

  def new
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_guilds')
    @guild = Guild.new
    #@guild.disciplines << Discipline.find(:first) # if Discipline.count > 0
    @submit = "Create new Guild"
  end

  def create
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_guilds')
    @guild = Guild.new(params[:guild])
    @guild.disciplines= get_disciplines_from_guild(params[:guild])
    if @guild.save
      flash[:notice] = "Guild succesfully created"
      redirect_to @guild
    else
      flash[:notice] = "NOT created guild. #{params[:guild]}"
      #      flash[:notice] = "NOT created guild. #{get_disciplines_from_guild(params[:guild])}"
      render :action => 'new'
    end
  end

  def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_guilds')
    @guild = Guild.find(params[:id])
    @submit = "Update Guild"
  end

  def update
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_guilds')
    @guild = Guild.find(params[:id])
    @guild.disciplines= get_disciplines_from_guild(params[:guild])
    if @guild.update_attributes(params[:guild])
      flash[:notice] = "Guild succesfully updated"
      redirect_to @guild
    else
      render :action => 'edit'
    end
  end

  def destroy
  end

  def join
		deny_access and return unless signed_in?
		@guild = Guild.find(params[:id])
		current_user.guilds << @guild unless current_user.guilds.include? @guild
		flash[:notice] = "Succesfully joined the guild"
		redirect_to @guild
  end

  private

  def get_disciplines_from_guild par
    ds = []
    par[:disciplines_attributes].each_value { |v|
      d = Discipline.find(v["id"])
      ds << d if d.instance_of? Discipline and v["_destroy"] != "1"
    } unless par[:disciplines_attributes].nil?
    return ds
  end

end
