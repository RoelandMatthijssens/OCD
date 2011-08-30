class GuildsController < ApplicationController
  def index
		#deny_access and return unless signed_in?
		#deny_privileged_access and return unless current_user.can?('view_guilds')
    @title = "Guilds"
    @guilds = Guild.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
    @guild = Guild.find(params[:id])
    @materials = @guild.materials
    @selected_discipline = ""
    @selected_year_type = ""
		#deny_access and return unless signed_in?
		#deny_privileged_access and return unless current_user.can?('view_guilds') || current_user.guilds.include?(@guild)
  end
  
  def update_filter
    @guild = Guild.find(params[:id]) 
    @materials = get_materials params[:filter][:discipline_id], params[:filter][:year_type]
    @selected_discipline = params[:filter][:discipline_id]
    @selected_year_type = params[:filter][:year_type]
    render :action => 'show'
  end
  
  def new
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_guilds')
    @guild = Guild.new
    #@guild.disciplines << Discipline.find(:first) # if Discipline.count > 0
    @dis_fac_inst = []
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
      @dis_fac_inst = get_dis_fac_inst_from_par(params[:guild])
      flash[:notice] = "NOT created guild. #{params[:guild]}"
      #      flash[:notice] = "NOT created guild. #{get_disciplines_from_guild(params[:guild])}"
      render :action => 'new'
    end
  end

  def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_guilds')
    @guild = Guild.find(params[:id])
    @dis_fac_inst = get_dis_fac_inst_from_guild(@guild)
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
      @dis_fac_inst = get_dis_fac_inst_from_par(params[:guild])
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

  def get_disciplines_from_guild par
    ds = []
    par[:disciplines_attributes].each_value { |v|
      unless v["id"].empty?
        d = Discipline.find(v["id"])
        ds << d if d.instance_of? Discipline and v["_destroy"] != "1"
      end
    } unless par[:disciplines_attributes].nil?
    return ds
  end
  
  def get_dis_fac_inst_from_par par
    ds = []
    fac = []
    inst = []
    par[:disciplines_attributes].each_value { |v|
      if v["id"]
        ds << v["id"] 
        fac << v["faculty_id"]
        inst << v["institute_id"]
      end
    } unless par[:disciplines_attributes].nil?
    return [inst, fac, ds]
  end
  
  def get_dis_fac_inst_from_guild guild
    ds = []
    fac = []
    inst = []
    guild.disciplines.each{ |d|
      ds << d.id
      fac << d.faculty_id
      inst << d.institute_id
    }
    return [inst, fac, ds]
  end

  def get_materials discipline_id, year_type
    subjects = Subject.includes(:teachings).where("teachings.discipline_id = #{discipline_id} and subjects.year_type='#{year_type}'")
    materials = []
    subjects.each { |s| materials.concat(s.materials)}
    return materials
  end
end
