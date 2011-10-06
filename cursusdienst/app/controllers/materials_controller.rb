class MaterialsController < ApplicationController

  def index
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_materials')
    @title = t(:all_materials, :scope => "titles")
    @materials = Material.active.paginate(:page => params[:page], :per_page => 10)
    inst = Guild.find_by_initials(request.subdomain).disciplines.first.faculty.institute_id
    @select_boxes = [inst]
  end

  def update_filter
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('view_materials')
    @select_boxes = [params[:institute_id],params[:faculty_id],params[:discipline_id],params[:subject_id]]
    @title = t(:all_subjects, :scope => "titles" )
    @materials = Material.active.find(:all, :conditions => ["subject_id = ?", params[:subject_id]]).paginate(:page => params[:page], :per_page => 10)
    render :action => 'index'
  end

  def show
    #deny_access and return unless signed_in?
    #deny_privileged_access and return unless current_user.can?('view_materials')
    @material = Material.find(params[:id])
    @rating = Rating.new
  end

  def new
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('create_materials')
    if params[:subject_id]
      @material = Subject.find(params[:subject_id]).materials.new
    elsif params[:parent_id]
      @material = Material.new :parent_id => Material.deleted.unchecked_find(params[:parent_id])
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
    @material.printable = params[:material][:printable]
    set_options_attributes params[:material][:options_attributes]
    if params[:parent_id] && ! params[:parent_id].empty?
      @parent = Material.find(params[:parent_id])
      @material.subject_id = @parent.subject_id
    end

    if @material.save
      flash[:succes] = t(:new_material_success, :scope => "flash")
      if params[:delete_previous] && params[:delete_previous] ==  '1'
        temp = Material.find(params[:parent_id])
        temp.deleted = true
        unless temp.save
          filter = params[:material]
          flash[:notice] = t(:new_material_fail, :scope => "flash")
          set_dataset_from_params params
          render 'new'
        end
      end
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
    @material = Material.unchecked_find(params[:id])
    @material.subject = nil unless subject_given?(params[:material])

    set_options_attributes params[:material][:options_attributes]
    #    @material.subject_id = nil if !params[:material][:subject_id]
    #    @material.parent_id = nil if !params[:material][:parent_id]
    if @material.update_attributes(params[:material])
      remove_attachments params[:remove_attachments]
      @material.save!
      flash[:succes] = t(:update_material_success, :scope => "flash" )
      redirect_to @material
    else
      set_dataset_from_params params
      render 'edit'
    end
  end

  def add_to_cart
    if signed_in?
      @material = Material.find(params[:id])
      @guild = Guild.find_by_initials!(request.subdomain)
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
        format.json { render :json => [t(:added_to_cart, :scope => "flash", :material => @material.name, :subject => @material.subject.name, :type => @material.typee)] }
      end
    else
      respond_to do |format|
        format.html{  flash[:error] = t(:login_to_buy, :scope => "flash" ) }
        #format.json { render :json => [t(:added_to_cart, :scope => "flash", :materials => @material.name )] }
        format.json { render :json => [t(:login_to_buy, :scope => "flash")] }
      end
    end
  end

  def destroy
    deny_access and return unless signed_in?
    deny_privileged_access and return unless current_user.can?('delete_materials')
    @material = Material.find(params[:id])
    @material.deleted = true
    if @material.save!
      flash[:succes] = t(:delete_material_success, :scope => "flash" )
    else
      flash[:error] = t(:delete_material_fail, :scope => "flash" )
    end
    redirect_to @material
  end

  private

  def remove_attachments par
    par.each_key { |attachtment_id|
      attachment = Attachment.find(attachtment_id)
      attachment.destroy
      File.delete(attachment.item.path) if File.exists?(attachment.item.path)
    } if par
  end

  def subject_given? par
    return par[:subject_id]
  end

  def set_options_attributes options_attributes
    @material.options = []
    options_attributes.each_value { |v|
      unless v["id"].empty?
        d = Option.find(v["id"])
        @material.options << d if d.instance_of? Option and v["_destroy"] != "1"
      end
    }
  end

  def get_options_from_material par
    os = []
    par[:options_attributes].each_value { |v|
      unless v["id"] = ""
        o = Option.find(v["id"])
        os << o if o.instance_of? Option and v["_destroy"] != "1"
      end
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

  def set_given_subj subject
    if subject
      discipline = subject.disciplines.first
      @subject_params_institute = [get_institutes, discipline.faculty.institute_id.to_s]
      @subject_params_faculty = [get_faculties(discipline.faculty.institute_id.to_s), discipline.faculty_id.to_s]
      @subject_params_discipline = [get_disciplines(discipline.faculty_id.to_s), discipline.id.to_s]
      @subject_params_subject = [get_subjects(discipline.id.to_s), subject.id.to_s]
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
