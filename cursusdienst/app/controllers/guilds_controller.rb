class GuildsController < ApplicationController
	def index
    @title = t(:all_guilds, :scope => "titles")
    @guilds = Guild.paginate(:page => params[:page], :per_page => 10)
  end
  
  def show
#    @guild = Guild.find(params[:id])
    @guild = Guild.find_by_initials!(request.subdomain) 
    @subjects = @guild.subjects
    @selected_discipline = ""
    @selected_year_type = ""
  end
  
  def news
    @guild = Guild.find_by_initials!(request.subdomain)
  end
  
  def update_filter
    @guild = Guild.find_by_initials!(request.subdomain)
    @subjects = get_materials params[:filter][:discipline_id], params[:filter][:year_type]
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
    @submit = t(:new_guild, :scope => "buttons")
  end

  def create
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_guilds')
    @guild = Guild.new(params[:guild])
    @guild.disciplines= get_disciplines_from_guild(params[:guild])
    if @guild.save
      flash[:notice] = t(:new_guild_success, :scope => "flash")
      redirect_to root_url(:subdomain => @guild.initials)
    else
      @dis_fac_inst = get_dis_fac_inst_from_par(params[:guild])
      flash[:notice] = t(:new_guild_fail, :scope => "flash")
      render :action => 'new'
    end
  end

  def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_guilds')
    @guild = Guild.find_by_initials!(request.subdomain)
    @dis_fac_inst = get_dis_fac_inst_from_guild(@guild)
    @submit = t(:update_guild, :scope => "buttons")
  end

  def update
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_guilds')
    @guild = Guild.find_by_initials!(request.subdomain)
    @guild.disciplines= get_disciplines_from_guild(params[:guild])
    if @guild.update_attributes(params[:guild])
      flash[:notice] = t(:update_guild_success, :scope => "flash")
      redirect_to root_url(:subdomain => @guild.initials)
    else
      @dis_fac_inst = get_dis_fac_inst_from_par(params[:guild])
      render :action => 'edit'
    end
  end

  def destroy
  end

  def join
		deny_access and return unless signed_in?
		@guild = Guild.find_by_initials!(request.subdomain)
		current_user.guilds << @guild unless current_user.guilds.include? @guild
		flash[:notice] = t(:join_guild_success, :scope => "flash")
		redirect_to root_url(:subdomain => @guild.initials)
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
    return subjects
  end
end
