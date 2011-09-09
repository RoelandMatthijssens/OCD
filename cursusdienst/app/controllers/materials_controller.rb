class MaterialsController < ApplicationController

  def index
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_materials')
    @title = t(:all_materials, :scope => "titles")
    @materials = Material.paginate(:page => params[:page], :per_page => 10)
  end

  def show
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('view_materials')
    @material = Material.find(params[:id])
  end

  def new
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_materials')
    subject =  params[:subject] && Subject.find(params[:subject])
    parent = params[:parent] && Material.find(params[:parent])
    if subject 
      @material = subject.materials.new
      set_given_subject @material
    elsif parent
      @material = Material.new :parent => parent
      set_given_parent @material
    else
      @material = Material.new
    end
    @submit = t(:new_material, :scope => "buttons")
    set_dataset
  end

  def create
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('create_materials')
    @material = Material.new(params[:material])
    @material.options= get_options_from_material(params[:material])
    if @material.save
      flash[:succes] = t(:new_material_success, :scope => "flash")
      redirect_to @material
    else
      filter = params[:material]
			flash[:notice] = t(:new_material_fail, :scope => "flash")
      set_dataset_from_params params
      render 'new'
    end
  end

  def edit
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_materials')
    @material = Material.find(params[:id])
    @parents = @material.subject ? @material.subject.materials : nil
    set_given_subject @material
    set_given_parent @material
    @submit = t(:update_material, :scope => "buttons")
  end

  def update
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('edit_materials')
    @material = Material.find(params[:id])
    @material.subject = nil unless subject_given?(params[:material])
    @material.options = get_options_from_material(params[:material])
    #    @material.subject_id = nil if !params[:material][:subject_id]
    #    @material.parent_id = nil if !params[:material][:parent_id]
    if @material.update_attributes(params[:material])
      flash[:succes] = t(:update_material_success, :scope => "flash" )
      redirect_to @material
    else
      set_dataset_from_params params
      render 'edit'
    end
  end

	def sell
		deny_access and return unless signed_in?
		deny_privileged_access and return unless current_user.can?('sell_materials')
		@material = Material.find(params[:id])
		g = current_user.guilds
		if g.empty?
			redirect_to home_path
		elsif g.size == 1
			g = g.first
			if g.materials.include?(@material)
				flash[:succes] = t(:already_selling, :scope => "flash", :guild => g.name, :material => @material.name)
			else
				g.materials << @material
				flash[:succes] = t(:now_selling, :scope => "flash", :guild => g.name, :material => @material.name)
			end
			redirect_to materials_path
		else
			flash[:succes] = t(:too_many_guilds, :scope => "flash")
			redirect_to materials_path
		end
	end

	def add_to_cart
		deny_access and return unless signed_in?
		@material = Material.find(params[:id])
		@guild = Guild.find(params[:guild_id])
		items = []
		item = ShoppingCartItem.find(:first,  :conditions => ['user_id = ? and material_id = ? and guild_id = ?',current_user.id , @material.id, @guild.id])
		if item
			item.amount += 1
		else
			item = ShoppingCartItem.new(:amount => 1)
			item.user = current_user
			item.material = @material
			item.guild = @guild
		end
		item.save!
		respond_to do |format|
			format.html{  flash[:success] = "#{@material}" }
			#format.json { render :json => [t(:added_to_cart, :scope => "flash", :materials => @material.name )] }
			format.json { render :json => [t(:added_to_cart, :scope => "flash", :material => @material.name)] }
		end
	end

  def destroy
  end

  private

  def subject_given? par
    return par[:subject_id]
  end

  def get_options_from_material par
    os = []
    par[:options_attributes].each_value { |v|
      o = Option.find(v["id"])
      os << o if o.instance_of? Option and v["_destroy"] != "1"
    } unless par[:options_attributes].nil?
    return os
  end

  def get_selected_item params = nil, type = nil, key = nil
    if type == :subject && key == :subject_id || type == :parent && key == :parent_id
      params && params[:material] && params[:material][key] ? params[:material][key] : ""
    else
      params && params[type] &&  params[type][key] ? params[type][key] : ""
    end
  end
  
  def set_empty_subject
    @subject_params_institute = [get_institutes, ""]
    @subject_params_faculty = [get_faculties, ""]
    @subject_params_discipline = [get_disciplines, ""]
    @subject_params_subject = [get_subjects, ""]
  end
  
  def set_empty_parent
    @parent_params_institute = [get_institutes, ""]
    @parent_params_faculty = [get_faculties, ""]
    @parent_params_discipline = [get_disciplines, ""]
    @parent_params_subject = [get_subjects, ""]
    @parent_params_material = [get_materials, ""]
  end
  
  def set_dataset
    set_empty_subject
    set_empty_parent
  end
  
  def set_dataset_from_params params
    @subject_params_institute = [get_institutes, get_selected_item(params, :subject, :institute_id)]
    @subject_params_faculty = [get_faculties(get_selected_item(params, :subject, :institute_id)), get_selected_item(params, :subject, :faculty_id)]
    @subject_params_discipline = [get_disciplines(get_selected_item(params, :subject, :faculty_id)), get_selected_item(params, :subject, :discipline_id)]
    @subject_params_subject = [get_subjects(get_selected_item(params, :subject, :discipline_id)), get_selected_item(params, :subject, :subject_id)]
    @parent_params_institute = [get_institutes, get_selected_item(params, :parent, :institute_id)]
    @parent_params_faculty = [get_faculties(get_selected_item(params, :parent, :institute_id)), get_selected_item(params, :parent, :faculty_id)]
    @parent_params_discipline = [get_disciplines(get_selected_item(params, :parent, :faculty_id)), get_selected_item(params, :parent, :discipline_id)]
    @parent_params_subject = [get_subjects(get_selected_item(params, :parent, :discipline_id)), get_selected_item(params, :parent, :subject_id)]
    @parent_params_material = [get_materials(get_selected_item(params, :parent, :subject_id)), get_selected_item(params, :parent, :material_id)]
  end
  
  def set_given_subject material
    if material.subject
      @subject_params_institute = [get_institutes, material.institute_id.to_s]
      @subject_params_faculty = [get_faculties(material.institute_id.to_s), material.faculty_id.to_s]
      @subject_params_discipline = [get_disciplines(material.faculty_id.to_s), material.discipline_id.to_s]
      @subject_params_subject = [get_subjects(material.discipline_id.to_s), material.subject_id.to_s]
    else
      set_empty_subject
    end
  end
  
  def set_given_parent material
    if @material.parent
      @parent_params_institute = [get_institutes, material.parent.institute_id.to_s]
      @parent_params_faculty = [get_faculties(material.parent.institute_id.to_s), material.parent.faculty_id.to_s]
      @parent_params_discipline = [get_disciplines(material.parent.faculty_id.to_s), material.parent.discipline_id.to_s]
      @parent_params_subject = [get_subjects(material.parent.discipline_id.to_s), material.parent.subject_id.to_s]
      @parent_params_material = [get_materials(material.parent.subject_id.to_s), material.parent_id.to_s]
    else
      set_empty_parent
    end
  end

end
