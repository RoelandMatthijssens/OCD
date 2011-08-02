class GuildsController < ApplicationController
  def index
    @title = "Guilds"
    @guilds = Guild.all
  end

  def show
    @guild = Guild.find(params[:id])
  end

  def new
    @guild = Guild.new
    #@guild.disciplines << Discipline.find(:first) # if Discipline.count > 0
    @submit = "Create new Guild"
  end

  def create
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
    @guild = Guild.find(params[:id])
    @submit = "Update Guild"
  end

  def update
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
